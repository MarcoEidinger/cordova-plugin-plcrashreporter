//
//  CrashLogger.h
//  crashlogger
//
//  Created by Eidinger, Marco on 10/2/15.
//
//

#import <Cordova/CDV.h>

/**
 main class and access point for native plugin development
 */
@interface CrashLogger : CDVPlugin

- (void)initialize: (CDVInvokedUrlCommand*)command;
- (void)hasPendingCrashReports: (CDVInvokedUrlCommand*)command;

@end
