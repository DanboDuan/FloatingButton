//
//  FloatingWrapper.h
//  FloatingButton
//
//  Created by bob on 2019/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FloatingWrapper : UIWindow

+ (instancetype)floatingWrapper;

#pragma mark - window

- (void)showWrapperWindow;

- (void)hideWrapperWindow;

- (void)removeFromScreen;

#pragma mark - wrapper

- (void)showWrapperViewAtPoint:(CGPoint)point;

- (void)showWrapperViewWithFrame:(CGRect)frame;

- (void)hideWrapperView;

#pragma mark - present

- (void)presentView:(UIView *)view;

- (void)dismissPresentedView;

@end

NS_ASSUME_NONNULL_END
