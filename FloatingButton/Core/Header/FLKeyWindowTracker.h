//
//  FLKeyWindowTracker.h
//  FloatingButton
//
//  Created by bob on 2019/8/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString * const FLDefaultSceneName;

@interface FLKeyWindowTracker : NSObject

/*! @abstract keyWindow for keyScene
@discussion setter is equal to `-[FLKeyWindowTracker trackScene:keyScene keyWindow:keyWindow]`
 getter is equal to `-[FLKeyWindowTracker keyWindowForScene:keyScene]`
*/
@property (nonatomic, strong) UIWindow *keyWindow;

/*! @abstract key Scene
@discussion  default is FLDefaultSceneName
*/
@property (atomic, copy) NSString *keyScene;

+ (instancetype)sharedInstance;

- (void)trackScene:(NSString *)name keyWindow:(nullable UIWindow *)keyWindow;
- (UIWindow *)keyWindowForScene:(NSString *)name;
- (void)removeKeyWindowForScene:(NSString *)name; // when you want set nil

@end

NS_ASSUME_NONNULL_END
