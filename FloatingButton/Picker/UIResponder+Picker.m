//
//  UIResponder+Picker.m
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import "UIResponder+Picker.h"
#import "ScreenHelper.h"

NSString * const kFLResponderPathSeperator = @"/";

@implementation UIResponder (Picker)

- (NSString *)fl_viewControllerPath {

    UIViewController *responder = (UIViewController *)self;
    UIViewController *parent = responder.parentViewController;
    if (parent
        && ![parent isKindOfClass:[UINavigationController class]]
        && ![parent isKindOfClass:[UITabBarController class]]
        && (![parent isKindOfClass:[UIPageViewController class]] || [ScreenHelper isMultiPage:parent])
        //        && ![parent isKindOfClass:[UISplitViewController class]]
        ) {

        NSArray *childs = [parent childViewControllers];
        return [NSString stringWithFormat:@"%@%@%@",[parent fl_viewControllerPath], kFLResponderPathSeperator, [self fl_pathIndexOfSameClass:childs]];
    }

    return NSStringFromClass(self.class);
}

- (NSString *)fl_responderPath {
    if ([self isKindOfClass:[UIViewController class]]) {
        return [self fl_viewControllerPath];
    }

    if ([self.nextResponder isKindOfClass:[UIView class]]) {
        UIView *parent = (UIView *)self.nextResponder;
        NSArray *childs = parent.subviews;
        return [NSString stringWithFormat:@"%@%@%@",[parent fl_responderPath], kFLResponderPathSeperator, [self fl_pathIndexOfSameClass:childs]];
    }

    if ([self.nextResponder isKindOfClass:[UIViewController class]]) {
        UIViewController *parent = (UIViewController *)self.nextResponder;
        return [NSString stringWithFormat:@"%@%@%@[0]",[parent fl_viewControllerPath], kFLResponderPathSeperator, NSStringFromClass(self.class)];
    }

    return NSStringFromClass(self.class);
}

- (NSString *)fl_pathIndexOfSameClass:(NSArray *)items {
    if (items.count <= 1) {
        return [NSString stringWithFormat:@"%@[0]", NSStringFromClass([self class])];
    }

    NSMutableArray *sameItems = [NSMutableArray new];
    for (NSObject *item in items) {
        if (item) {
            if ([NSStringFromClass([self class]) isEqualToString:NSStringFromClass([item class])]) {
                [sameItems addObject:item];
            }
        }
    }

    NSUInteger index = [sameItems indexOfObject:self];
    return  [NSString stringWithFormat:@"%@[%lu]", NSStringFromClass([self class]), (unsigned long)index];
}

@end
