//
//  UIView+Picker.m
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import "UIView+Picker.h"
#import "ScreenHelper.h"

@implementation UIView (Picker)

- (UIViewController *)fl_controller {
    UIResponder *nextResponder = [self nextResponder];
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *parent = ((UIViewController *)nextResponder).parentViewController;

            if ([parent isKindOfClass:[UINavigationController class]]
                ||[parent isKindOfClass:[UITabBarController class]]
                ||([parent isKindOfClass:[UIPageViewController class]] && ![ScreenHelper isMultiPage:parent])) {

                return (UIViewController *)nextResponder;
            }

            if (!parent) {
                return (UIViewController *)nextResponder;
            }
        }
        nextResponder = nextResponder.nextResponder;
    }

    return nil;
}

- (NSArray<NSIndexPath *> *)fl_indexPath {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:1];
    UIResponder *nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return indexPaths;
    }

    if ([nextResponder isKindOfClass:[UIView class]]) {
        UIView *next = (UIView *)nextResponder;
        [indexPaths addObjectsFromArray:[next fl_indexPath]];
    }

    return indexPaths;
}

- (NSString *)fl_indexPathDescription {
    NSArray<NSIndexPath *> *indexPath = [self fl_indexPath];
    if (indexPath.count) {
        NSMutableString *description = [NSMutableString string];
        [indexPath enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL *stop) {
            [description appendFormat:@"[%zd-%zd]-", obj.section, obj.row];
        }];
        return description;
    }

    return @"Not in list";
}

@end
