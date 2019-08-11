//
//  ScreenHelper.h
//  FloatingButton
//
//  Created by bob on 2019/2/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScreenHelper : NSObject

+ (CGFloat)statusBarHeight;

+ (CGFloat)safeAreaInsetsTop;

+ (CGFloat)safeAreaInsetsBottom;

+ (CGFloat)screenWidth;

+ (BOOL)isMultiPage:(UIViewController *)page;

+ (UIImage *)imageForView:(UIView *)view;

+ (UIImage *)combineScreenImage:(UIImage *)first above:(UIImage *)second;

@end

NS_ASSUME_NONNULL_END
