//
//  FloatingButton.m
//  FloatingButton
//
//  Created by bob on 2019/3/16.
//

#import "FloatingButton.h"
#import "FloatingContainerWindow.h"
#import "ScreenHelper.h"
#import "UIColor+Hex.h"
#import "FLKeyWindowTracker.h"

#define FLPickerBlue                    [UIColor fl_colorWithRGB:0x4d64fd]
#define FB_Width    44.0

@interface FloatingButton ()

@property (nonatomic, weak) id<FloatingButtonDelegate> delegate;

@property (nonatomic, strong) FloatingContainerWindow *containerWindow;

@property (nonatomic, strong) UIView *pickerParent;

@end

@implementation FloatingButton

+ (instancetype)floatingButtonWithDelegate:(id<FloatingButtonDelegate>)delegate {
    FloatingButton *flButton = [[self alloc] initWithFrame:CGRectMake(0, 0, FB_Width, FB_Width)
                                                     color:FLPickerBlue
                                                  delegate:delegate];
    [flButton setTitle:@"FB" forState:(UIControlStateNormal)];

    return flButton;
}

- (instancetype)initWithFrame:(CGRect)frame
                        color:(UIColor*)color
                     delegate:(id<FloatingButtonDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.backgroundColor = color;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.layer.cornerRadius = frame.size.width/2.0;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2;
        self.clipsToBounds = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        [self addTarget:self action:@selector(floatingButtonTap) forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

#pragma mark - internal

- (void)handlePanGesture:(UIPanGestureRecognizer *)p {
    UIWindow *appWindow = [FLKeyWindowTracker sharedInstance].keyWindow ?: [UIApplication sharedApplication].keyWindow;
    CGPoint panPoint = [p locationInView:appWindow];

    if(p.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(floatingButton:moveStartFrom:)]) {
            [self.delegate floatingButton:self moveStartFrom:panPoint];
        }
    } else if(p.state == UIGestureRecognizerStateChanged) {
        self.containerWindow.center = panPoint;
        if ([self.delegate respondsToSelector:@selector(floatingButton:moveTo:)]) {
            [self.delegate floatingButton:self moveTo:panPoint];
        }
    } else if (p.state == UIGestureRecognizerStateEnded || p.state == UIGestureRecognizerStateCancelled) {
        if ([self.delegate respondsToSelector:@selector(floatingButton:moveEndTo:)]) {
            [self.delegate floatingButton:self moveEndTo:panPoint];
        }
        [self moveToSide:panPoint];
    }
}

- (void)moveToSide:(CGPoint)panPoint {
    CGFloat ballWidth = self.frame.size.width;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight =  [[UIScreen mainScreen] bounds].size.height;

    CGFloat left = fabs(panPoint.x);
    CGFloat right = fabs(screenWidth - left);

    CGFloat minSpace = MIN(left, right);
    CGPoint newCenter = CGPointZero;
    CGFloat targetY = panPoint.y;


    if (targetY - ballWidth/2 < [ScreenHelper safeAreaInsetsTop]) {
        targetY =   [ScreenHelper safeAreaInsetsTop] + ballWidth/2;
    }

    if (targetY + ballWidth/2 > screenHeight - [ScreenHelper safeAreaInsetsBottom]) {
        targetY =   screenHeight  - [ScreenHelper safeAreaInsetsBottom] - ballWidth/2;
    }

    CGFloat centerXSpace = ballWidth /2;

    if (minSpace == left) {
        newCenter = CGPointMake(centerXSpace, targetY);
    }else if (minSpace == right) {
        newCenter = CGPointMake(screenWidth - centerXSpace, targetY);
    }

    [UIView animateWithDuration:.25 animations:^{
        self.containerWindow.center = newCenter;
    }];
}

#pragma mark - some utility

- (UIView *)pickerParent {
    if (!_pickerParent) {
        _pickerParent = [[UIView alloc] initWithFrame:self.bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(floatingButtonTap)];
        [_pickerParent addGestureRecognizer:tap];
        _pickerParent.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }

    return _pickerParent;
}

#pragma mark - public

- (void)showFloatingButton {
    if (self.containerWindow) {
        self.containerWindow.hidden = NO;
        return;
    }

    FloatingContainerWindow *backWindow = [[FloatingContainerWindow alloc] initWithFrame:CGRectMake(0, 100, FB_Width, FB_Width)];
    backWindow.rootViewController = [UIViewController new];

    [self.pickerParent addSubview:self];
    backWindow.rootViewController.view = self.pickerParent;
    [backWindow setHidden:NO];
    self.containerWindow = backWindow;
}

- (void)hideFloatingButton {
    self.containerWindow.hidden = YES;
}

- (void)removeFromScreen {
    [self.containerWindow destroyWindow];
    self.containerWindow = nil;
    [self removeFromSuperview];
}

- (void)floatingButtonTap {
    if([self.delegate respondsToSelector:@selector(floatingButtonTap:)]) {
        [self.delegate floatingButtonTap:self];
    }
}

@end
