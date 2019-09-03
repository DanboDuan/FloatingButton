//
//  FloatingWrapper.m
//  FloatingButton
//
//  Created by bob on 2019/3/16.
//

#import "FloatingWrapper.h"
#import "UIView+Frame.h"
#import "UIColor+Hex.h"
#import "UIWindow+FloatingKey.h"
#import "FLKeyWindowTracker.h"

#define FLShadowGray    [UIColor fl_colorWithRGB:0x000000 alpha:0.7]

@interface FloatingWrapper ()

@property (nonatomic, strong) UIView *pickerWrapper;

@property (nonatomic, weak) UIView *lastPickedView;

@end

@implementation FloatingWrapper

+ (instancetype)floatingWrapper {
    FloatingWrapper *floatingView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return floatingView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = 999999;
        self.clipsToBounds = YES;
        self.rootViewController = [UIViewController new];
    }
    
    return self;
}

#pragma mark - window

- (void)showWrapperWindow {
    self.hidden = NO;
}

- (void)hideWrapperWindow {
    self.hidden = YES;
}

- (void)removeFromScreen {
    self.hidden = YES;
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    self.rootViewController = nil;
}

#pragma mark - wrapper

- (void)showWrapperViewAtPoint:(CGPoint)point {
    UIWindow *keyWindow = [FLKeyWindowTracker sharedInstance].keyWindow ?: [UIApplication sharedApplication].keyWindow;
    UIView *pickedView = [keyWindow hitTest:point withEvent:nil];

    if (pickedView && pickedView != self.lastPickedView) {
        self.lastPickedView = pickedView;
        CGRect pickerFrame = [keyWindow convertRect:pickedView.bounds fromView:pickedView];
        CGRect frame = CGRectIntersection(CGRectInset(pickerFrame, -4, -4),[UIScreen mainScreen].bounds);
        [self showWrapperViewWithFrame:frame];
    }
}

- (void)showWrapperViewWithFrame:(CGRect)frame {
    if (!self.pickerWrapper) {
        UIView *wrapper = [[UIView alloc] initWithFrame:frame];
        wrapper.layer.borderColor = [UIColor redColor].CGColor;
        wrapper.layer.borderWidth = 2.0;
        wrapper.clipsToBounds = YES;
        self.pickerWrapper = wrapper;

        CGRect inside = CGRectInset(wrapper.bounds, 2, 2);
        UIView *grayInside = [[UIView alloc] initWithFrame:inside];
        grayInside.backgroundColor = [UIColor redColor];
        grayInside.alpha = .2;
        grayInside.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [wrapper addSubview:grayInside];
    }
    [self.rootViewController.view insertSubview:self.pickerWrapper atIndex:0];
    self.pickerWrapper.frame = frame;
}

- (void)hideWrapperView {
    self.lastPickedView = nil;
    [self.pickerWrapper removeFromSuperview];
}

#pragma mark - present

- (void)presentView:(UIView *)view {
    if (view) {
        [self.rootViewController.view addSubview:view];
        self.rootViewController.view.backgroundColor = FLShadowGray;
    }
}

- (void)dismissPresentedView {
    [self.rootViewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (subView != self.pickerWrapper) {
            [subView removeFromSuperview];
        }
    }];
    self.rootViewController.view.backgroundColor = nil;
}

#pragma mark hitTest

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.rootViewController.presentedViewController) {
        return [super hitTest:point withEvent:event];
    }

    if (self.rootViewController.view.subviews.count) {
        return [super hitTest:point withEvent:event];
    }

    return nil;
}

@end
