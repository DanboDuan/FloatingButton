//
//  FloatingContainerWindow.m
//  FloatingButton
//
//  Created by bob on 2019/3/16.
//

#import "FloatingContainerWindow.h"
#import "UIWindow+FloatingKey.h"

FloatingNonKeyWindowClass(FloatingContainerWindow);

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

- (void)destroyWindow {
    self.hidden = YES;
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    
    self.rootViewController = nil;
}

@end
