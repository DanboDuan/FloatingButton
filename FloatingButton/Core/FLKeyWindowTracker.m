//
//  FLKeyWindowTracker.m
//  FloatingButton
//
//  Created by bob on 2019/8/11.
//

#import "FLKeyWindowTracker.h"

NSString * const FLDefaultSceneName  = @"Default Configuration";

@interface FLKeyWindowTracker ()

@property (nonatomic, strong) NSMapTable *keyWindows;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation FLKeyWindowTracker

+ (instancetype)sharedInstance {
    static FLKeyWindowTracker *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.keyWindows = [NSMapTable strongToWeakObjectsMapTable];
        self.semaphore = dispatch_semaphore_create(1);
        self.keyScene = FLDefaultSceneName;
    }

    return self;
}

- (void)trackScene:(NSString *)name keyWindow:(UIWindow *)keyWindow {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [self.keyWindows setObject:keyWindow forKey:name];
    dispatch_semaphore_signal(self.semaphore);
}

- (UIWindow *)keyWindowForScene:(NSString *)name {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    UIWindow *value = [self.keyWindows objectForKey:name];
    dispatch_semaphore_signal(self.semaphore);

    return value;
}

- (void)removeKeyWindowForScene:(NSString *)name {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [self.keyWindows removeObjectForKey:name];
    dispatch_semaphore_signal(self.semaphore);
}

- (UIWindow *)keyWindow {
    NSString *name = self.keyScene ?: FLDefaultSceneName;
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    UIWindow *value = [self.keyWindows objectForKey:name];
    dispatch_semaphore_signal(self.semaphore);

    return value;
}

- (void)setKeyWindow:(UIWindow *)keyWindow {
    NSString *name = self.keyScene ?: FLDefaultSceneName;
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [self.keyWindows setObject:keyWindow forKey:name];
    dispatch_semaphore_signal(self.semaphore);
}

@end
