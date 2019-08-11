//
//  NSObject+Picker.m
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import "NSObject+Picker.h"
#import <objc/runtime.h>

@implementation NSObject (Picker)

- (NSMutableDictionary *)fl_debugInfo {
    return objc_getAssociatedObject(self, @selector(fl_debugInfo));
}

- (void)setFl_debugInfo:(NSMutableDictionary *)fl_debugInfo {
    objc_setAssociatedObject(self, @selector(fl_debugInfo), fl_debugInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)fl_addDebugInfo:(NSDictionary *)info {
    NSCAssert(info, @"should not be nil");
    if (!info) {
        return;
    }
    
    NSMutableDictionary *debugInfo = self.fl_debugInfo;
    if (!debugInfo) {
        debugInfo = [NSMutableDictionary new];
        self.fl_debugInfo = debugInfo;
    }
    [debugInfo addEntriesFromDictionary:info];
}

@end
