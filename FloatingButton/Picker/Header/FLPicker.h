//
//  FLPicker.h
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FloatingButton, FloatingWrapper;

@interface FLPicker : NSObject

@property (nonatomic, strong, readonly) UIImage *pickedImage;
@property (nonatomic, strong, readonly) NSArray<NSString *> *infoList;
@property (nonatomic, strong) FloatingButton *flButton;
@property (nonatomic, strong) FloatingWrapper *flWrapper;

+ (instancetype)sharedInstance;

- (void)startPicker;
- (void)stopPicker;

@end

NS_ASSUME_NONNULL_END
