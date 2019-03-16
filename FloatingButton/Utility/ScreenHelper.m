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

@end
