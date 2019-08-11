//
//  UIView+Picker.h
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Picker)

- (UIViewController *)fl_controller;

- (NSArray<NSIndexPath *> *)fl_indexPath;

- (NSString *)fl_indexPathDescription;

@end

NS_ASSUME_NONNULL_END
