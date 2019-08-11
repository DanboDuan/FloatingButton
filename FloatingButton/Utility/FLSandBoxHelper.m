//
//  FLSandBoxHelper.m
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import "FLSandBoxHelper.h"

@implementation FLSandBoxHelper


+ (NSString *)userAgentString {
    static NSString * userAgentStr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        // Attempt to find a name for this application
        NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];

        NSData *latin1Data = [appName dataUsingEncoding:NSUTF8StringEncoding];
        appName = [[NSString alloc] initWithData:latin1Data encoding:NSISOLatin1StringEncoding];

        // If we couldn't find one, we'll give up (and ASIHTTPRequest will use the standard CFNetwork user agent)
        if (!appName) {
            appName = @"";
        }

        NSString *appVersion = nil;
        NSString *marketingVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString *developmentVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"];
        if (marketingVersionNumber && developmentVersionNumber) {
            if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
                appVersion = marketingVersionNumber;
            } else {
                appVersion = [NSString stringWithFormat:@"%@ rv:%@",marketingVersionNumber,developmentVersionNumber];
            }
        } else {
            appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
        }

        NSString *deviceName;
        NSString *OSName;
        NSString *OSVersion;
        NSString *locale = [[NSLocale currentLocale] localeIdentifier];

        UIDevice *device = [UIDevice currentDevice];
        deviceName = [device model];
        OSName = [device systemName];
        OSVersion = [device systemVersion];

        userAgentStr = [NSString stringWithFormat:@"%@ %@ (%@; %@ %@; %@)", appName, appVersion, deviceName, OSName, OSVersion, locale];
    });

    return userAgentStr;
}

@end
