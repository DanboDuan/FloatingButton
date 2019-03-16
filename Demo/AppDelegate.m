//
//  AppDelegate.m
//  Demo
//
//  Created by bob on 2019/2/11.
//  Copyright © 2019 bob. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoViewController.h"

#import <FloatingButton/FloatingButton.h>
#import <FloatingButton/FloatingWrapper.h>

@interface AppDelegate ()<FloatingButtonDelegate>

@property (nonatomic, strong) FloatingButton *flButton;
@property (nonatomic, strong) FloatingWrapper *flWrapper;
@property (nonatomic, weak) UIView *lastPickedView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[DemoViewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    FloatingButton *fl = [FloatingButton floatingButtonWithDelegate:self];
    [fl showFloatingButton];
    self.flButton = fl;

    FloatingWrapper *wrapper = [FloatingWrapper floatingWrapper];
    [wrapper showWrapperWindow];
    self.flWrapper = wrapper;
    
    return YES;
}

- (void)floatingButtonTap:(FloatingButton *)floatingButton {
    UIView *presentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"presentView";
    label.textColor = [UIColor blackColor];
    [presentView addSubview:label];

    [self.flWrapper presentView:presentView];
}

- (void)floatingButton:(FloatingButton *)floatingButton moveStartFrom:(CGPoint)point {
    [self.flWrapper dismissPresentedView];
}

- (void)floatingButton:(FloatingButton *)floatingButton moveTo:(CGPoint)point {
    [self.flWrapper showWrapperViewAtPoint:point];
}

- (void)floatingButton:(FloatingButton *)floatingButton moveEndTo:(CGPoint)point {
    [self.flWrapper hideWrapperView];
}


@end
