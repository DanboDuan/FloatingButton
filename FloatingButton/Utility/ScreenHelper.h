//
//  ScreenHelper.h
//  FloatingButton
//
//  Created by bob on 2019/2/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScreenHelper : NSObject

+ (CGFloat)statusBarHeight;

+ (CGFloat)safeAreaInsetsTop;

+ (CGFloat)safeAreaInsetsBottom;

+ (CGFloat)screenWidth;

@end

NS_ASSUME_NONNULL_END
