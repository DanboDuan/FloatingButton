//
//  UIWindow+FloatingKey.m
//  FloatingButton
//
//  Created by bob on 2019/8/11.
//

#import "UIWindow+FloatingKey.h"
#import "FLKeyWindowTracker.h"
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#include <mach-o/ldsyms.h>

static NSMutableArray<Class> *kNonKeyWindowClass = nil;
static BOOL FLIsNonKeyWindowClass(UIWindow *window) {
    if (!kNonKeyWindowClass) {
        return NO;
    }

    for (Class cls in kNonKeyWindowClass) {
        if ([window isKindOfClass:cls]) {
            return YES;
        }
    }

    return NO;
}

static NSArray<NSString *>* FLReadConfiguration(char *sectionName,const struct mach_header *mhp);
static void dyld_callback(const struct mach_header *mhp, intptr_t vmaddr_slide)
{
    NSArray *clsses = FLReadConfiguration(FloatingWindowSectName, mhp);
    NSMutableArray<Class> *nonKeyWindowClass = [NSMutableArray array];
    for (NSString *clsName in clsses) {
        Class cls;
        if (clsName) {
            cls = NSClassFromString(clsName);
            if (cls) {
                [nonKeyWindowClass addObject:cls];
            }
        }
    }
    if (!kNonKeyWindowClass) {
        kNonKeyWindowClass = nonKeyWindowClass;
    } else {
        [kNonKeyWindowClass addObjectsFromArray:nonKeyWindowClass];
    }
}

__attribute__((constructor))
void initProphet() {
    _dyld_register_func_for_add_image(dyld_callback);
}

static NSArray<NSString *>* FLReadConfiguration(char *sectionName,const struct mach_header *mhp)
{
    NSMutableArray *configs = [NSMutableArray array];
    unsigned long size = 0;
#ifndef __LP64__
    uintptr_t *memory = (uintptr_t*)getsectiondata(mhp, SEG_DATA, sectionName, &size);
#else
    const struct mach_header_64 *mhp64 = (const struct mach_header_64 *)mhp;
    uintptr_t *memory = (uintptr_t*)getsectiondata(mhp64, SEG_DATA, sectionName, &size);
#endif

    unsigned long counter = size/sizeof(void*);
    for(int idx = 0; idx < counter; ++idx){
        char *string = (char*)memory[idx];
        NSString *str = [NSString stringWithUTF8String:string];
        if(!str)continue;
        if(str) [configs addObject:str];
    }

    return configs;
}

@implementation UIWindow (FloatingKey)

- (UIWindow *)fl_topWindow {
    UIWindow *topWindow = nil;
    NSMutableArray <UIWindow *> *windows = [NSMutableArray new];
#ifdef __IPHONE_13_0
    if (@available(iOS 13, *)) {
        [windows addObjectsFromArray: self.windowScene.windows ?: @[]];
    }
#endif
    if (windows.count < 1) {
        [windows addObjectsFromArray: [UIApplication sharedApplication].windows ?: @[]];
    }

    for (UIWindow *window in windows.reverseObjectEnumerator) {
        if (window.hidden == YES || window.opaque == NO) {
            continue;
        }

        if (FLIsNonKeyWindowClass(window)) {
            continue;
        }

        if (!topWindow || window.windowLevel > topWindow.windowLevel) {
            topWindow = window;
        }
    }

    return topWindow ?: [FLKeyWindowTracker sharedInstance].keyWindow;
}

@end
