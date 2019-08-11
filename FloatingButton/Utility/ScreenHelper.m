//
//  ScreenHelper.m
//  FloatingButton
//
//  Created by bob on 2019/2/13.
//

#import "ScreenHelper.h"

@implementation ScreenHelper

+ (CGFloat)statusBarHeight {
    if ([UIApplication sharedApplication].statusBarHidden) return 0;

    CGSize size =  [UIApplication sharedApplication].statusBarFrame.size;
    
    return MIN(size.width, size.height);
}

+ (CGFloat)safeAreaInsetsTop {
    CGFloat top = [self statusBarHeight];

    if (@available(iOS 11.0, *))  {
        top =[UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    }

    return top;
}

+ (CGFloat)safeAreaInsetsBottom {
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *))  {
        bottom =[UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    
    return bottom;
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (BOOL)isMultiPage:(UIViewController *)page {
    if ([page isKindOfClass:[UIPageViewController class]]) {
        UIPageViewController *parent = (UIPageViewController *)page;
        return parent.viewControllers.count > 1;
    }

    return NO;
}

+ (UIImage *)imageForView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage *)combineScreenImage:(UIImage *)first above:(UIImage *)second {
    CGRect rect = [UIScreen mainScreen].bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    [second drawInRect:rect];
    [first drawInRect:rect];

    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
