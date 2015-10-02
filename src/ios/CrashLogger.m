//
//  CrashLogger.m
//  crashlogger
//
//  Created by Eidinger, Marco on 10/2/15.
//
//

#import "CrashLogger.h"
#import <CrashReporter/CrashReporter.h>

@interface CrashLogger()
@end

@implementation CrashLogger

#pragma mark -
#pragma mark public methods
#pragma mark -

-(void)initialize: (CDVInvokedUrlCommand*)command {
	CDVPluginResult *pluginResult = nil;
    NSError *error;
	PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    if (![crashReporter enableCrashReporterAndReturnError: &error]) {
        NSLog(@"Warning: Could not enable crash reporter: %@", error);
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Could not enable crash reporter"];
    } else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)hasPendingCrashReports: (CDVInvokedUrlCommand*)command {
	PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    BOOL hasPendingCrashReport = [crashReporter hasPendingCrashReport];
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:hasPendingCrashReport];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end
