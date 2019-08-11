//
//  UIColor+Hex.h
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (instancetype)fl_colorWithRGB:(UInt32)hex;
+ (instancetype)fl_colorWithRGBA:(UInt32)hex;
+ (instancetype)fl_colorWithRGB:(UInt32)hex alpha:(CGFloat)alpha;

- (UIImage *)fl_imageWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
