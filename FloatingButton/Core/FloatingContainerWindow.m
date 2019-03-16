//
//  FloatingContainerWindow.m
//  FloatingButton
//
//  Created by bob on 2019/3/16.
//

#import "FloatingContainerWindow.h"

@implementation FloatingContainerWindow

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = 1000000;
        self.clipsToBounds = YES;
    }

    return self;
}

-(void)becomeKeyWindow {
    [super becomeKeyWindow];
    [[self fl_topWindow] makeKeyAndVisible];
}

- (UIWindow *)fl_topWindow {
    UIWindow *topWindow = nil;
    NSArray <UIWindow *>*windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows.reverseObjectEnumerator) {
        if (window.hidden == YES || window.opaque == NO) {
            continue;
        }

        if (CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds) == NO) {
            continue;
        }

        if ([window isKindOfClass:[self class]]) {
            continue;
        }

        if (!topWindow || window.windowLevel > topWindow.windowLevel){
            topWindow = window;
        }
    }

    return topWindow ?: [UIApplication sharedApplication].delegate.window;
}

- (void)destroyWindow {
    self.hidden = YES;
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    self.rootViewController = nil;
}

@end
