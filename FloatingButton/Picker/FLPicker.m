//
//  FLPicker.m
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import "FLPicker.h"
#import "FloatingWrapper.h"
#import "FloatingButton.h"
#import "FLSandBoxHelper.h"
#import "ScreenHelper.h"
#import "NSObject+Picker.h"
#import "UIResponder+Picker.h"
#import "UIView+Picker.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "FLPresenterViewController.h"

#define FLPickerBlue                    [UIColor fl_colorWithRGB:0x4d64fd]

@interface FLPicker ()<FloatingButtonDelegate>

@property (nonatomic, strong) FloatingButton *flButton;
@property (nonatomic, strong) FloatingWrapper *flWrapper;
@property (nonatomic, assign) BOOL presentingFlWrapper;

#pragma mark - debug info
@property (nonatomic, strong) UIImage *pickedImage;
@property (nonatomic, strong) NSArray<NSString *> *infoList;

@end

@implementation FLPicker

+ (instancetype)sharedInstance {
    static FLPicker *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (void)startPicker {
    if (!self.flButton) {
        FloatingButton *fl = [FloatingButton floatingButtonWithDelegate:self];
        self.flButton = fl;
    }
    [self.flButton showFloatingButton];
    if (!self.flWrapper)  {
        FloatingWrapper *wrapper = [FloatingWrapper floatingWrapper];
        [wrapper showWrapperWindow];
        self.flWrapper = wrapper;
    }
}

- (void)stopPicker {
    [self.flButton hideFloatingButton];
}

#pragma mark - FloatingButtonDelegate

- (void)floatingButtonTap:(FloatingButton *)floatingButton {
    if (self.presentingFlWrapper) {
        [self.flWrapper dismissPresentedView];
        self.presentingFlWrapper = NO;
        return;
    }
    
    self.presentingFlWrapper = YES;
    UIView *presentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(floatingButton.window.right + 20, floatingButton.window.top, 100, 300)];
    label.text = [FLSandBoxHelper userAgentString];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    label.backgroundColor = FLPickerBlue;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
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
    UIView *picked = self.flWrapper.lastPickedView;
    self.pickedImage = [ScreenHelper imageForView:picked];
    [self fetchInfoFromView:picked];
    [self.flWrapper hideWrapperView];
    [self.flWrapper.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:[FLPresenterViewController new]] animated:YES completion:nil];
}

#pragma mark - information

- (void)fetchInfoFromView:(UIView *)view {
    NSString *path = [NSString stringWithFormat:@"View Path: %@",[view fl_responderPath]];
    NSString *vc = [NSString stringWithFormat:@"UIViewController: %@",[view fl_controller]];
    NSString *frame = [NSString stringWithFormat:@"Frame: %@",NSStringFromCGRect(view.frame)];
    CGRect frameWindow = [view.window convertRect:view.bounds fromView:view];
    NSString *frameInWindow = [NSString stringWithFormat:@"Frame In Window: %@",NSStringFromCGRect(frameWindow)];
    NSString *indexPath= [NSString stringWithFormat:@"indexPath: %@",[view fl_indexPathDescription]];

    NSMutableArray <NSString *> *list = [NSMutableArray arrayWithArray:@[path , vc, frame, frameInWindow, indexPath]];
    [view.fl_debugInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [list addObject:[NSString stringWithFormat:@"%@: %@", key, obj]];
    }];

    self.infoList = list;
}

@end
