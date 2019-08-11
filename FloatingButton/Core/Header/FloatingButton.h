//
//  FloatingButton.h
//  FloatingButton
//
//  Created by bob on 2019/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FloatingButton;

@protocol FloatingButtonDelegate <NSObject>

@optional

- (void)floatingButtonTap:(FloatingButton *)floatingButton;
- (void)floatingButton:(FloatingButton *)floatingButton moveStartFrom:(CGPoint)point;
- (void)floatingButton:(FloatingButton *)floatingButton moveTo:(CGPoint)point;
- (void)floatingButton:(FloatingButton *)floatingButton moveEndTo:(CGPoint)point;

@end

@interface FloatingButton : UIButton

@property (nonatomic, assign, readonly) BOOL isShowActions;

/*! @abstract create FloatingButton
@discussion  if iOS 13 set the windowScene to it
 FloatingButton *button = xxx;
 button.window.windowScene = windowScene;
 ...
*/
+ (instancetype)floatingButtonWithDelegate:(id<FloatingButtonDelegate>)delegate;

- (void)showFloatingButton;

- (void)hideFloatingButton;

- (void)removeFromScreen;

@end


NS_ASSUME_NONNULL_END
