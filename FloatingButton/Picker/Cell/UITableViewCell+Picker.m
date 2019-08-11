//
//  UITableViewCell+Picker.m
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import "UITableViewCell+Picker.h"
#import "UIView+Picker.h"
#import "UIResponder+Picker.h"

@implementation UITableViewCell (Picker)

- (NSString *)fl_responderPath {
    UIResponder *parent = self.nextResponder;
    return [NSString stringWithFormat:@"%@%@%@[]",[parent fl_responderPath], kFLResponderPathSeperator,  NSStringFromClass(self.class)];
}

- (NSArray<NSIndexPath *> *)fl_indexPath {
    UIResponder *parent = self.nextResponder;
    NSIndexPath *index = nil;
    if ([parent isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)parent;
        index = [tableView indexPathForCell:self];
    }

    NSMutableArray<NSIndexPath *> * indexs= [[super fl_indexPath] mutableCopy];
    if (index)  [indexs addObject:index];

    return indexs;
}

@end
