//
//  NSObject+Picker.h
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Picker)

@property (nonatomic, strong) NSMutableDictionary *fl_debugInfo;

- (void)fl_addDebugInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
