//
//  UICollectionViewCell+Picker.m
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import "UICollectionViewCell+Picker.h"
#import "UIView+Picker.h"
#import "UIResponder+Picker.h"

@implementation UICollectionViewCell (Picker)

- (NSString *)fl_responderPath {
    UIResponder *parent = self.nextResponder;
    return [NSString stringWithFormat:@"%@%@%@[]",[parent fl_responderPath], kFLResponderPathSeperator,  NSStringFromClass(self.class)];
}

- (NSArray<NSIndexPath *> *)fl_indexPath {
    UIResponder *parent = self.nextResponder;
    NSIndexPath *index = nil;
    if ([parent isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)parent;
        index = [collectionView indexPathForCell:self];
    }

    NSMutableArray<NSIndexPath *> * indexs= [[super fl_indexPath] mutableCopy];
    if (index)  [indexs addObject:index];

    return indexs;
}

@end
