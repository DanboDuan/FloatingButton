//
//  UIWindow+FloatingKey.h
//  FloatingButton
//
//  Created by bob on 2019/8/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef FloatingWindowSectName

#define FloatingWindowSectName "FLWindowData"

#endif

#define FloatingData(sectname) __attribute((used, section("__DATA,"#sectname" ")))

#define FloatingNonKeyWindowClass(name) \
char * k##name##_window FloatingData(FLWindowData) = ""#name"";

@interface UIWindow (FloatingKey)

- (UIWindow *)fl_topWindow;

@end

NS_ASSUME_NONNULL_END
