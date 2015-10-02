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

- (void)hasPendingCrashReport: (CDVInvokedUrlCommand*)command {
	PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    BOOL hasPendingCrashReport = [crashReporter hasPendingCrashReport];
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:hasPendingCrashReport];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)loadPendingCrashReport: (CDVInvokedUrlCommand*)command {
    CDVPluginResult *pluginResult = nil;
    NSData *crashData;
    NSError *error;
    
    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    crashData = [crashReporter loadPendingCrashReportDataAndReturnError: &error];
    if (crashData == nil) {
        NSLog(@"Could not load crash report: %@", error);
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Could not load crash report"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }

    PLCrashReport *report = [[PLCrashReport alloc] initWithData: crashData error: &error];
    if (report == nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Could not parse crash report"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    
    NSString *humanReadableReport = [PLCrashReportTextFormatter stringValueForCrashReport:report withTextFormat:PLCrashReportTextFormatiOS];
    
    NSMutableDictionary *resultInfo = [NSMutableDictionary dictionaryWithCapacity:0];
    [resultSetDic setObject:report.systemInfo.timestamp forKey:@"timestamp"];
    [resultSetDic setObject:report.signalInfo.name forKey:@"signal"];
    [resultSetDic setObject:report.signalInfo.code forKey:@"code"];
    [resultSetDic setObject:report.signalInfo.address forKey:@"address"];
    [resultSetDic setObject:humanReadableReport forKey:@"report"];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:hasPendingCrashReport];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)purgePendingCrashReport: (CDVInvokedUrlCommand*)command {
    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    [crashReporter purgePendingCrashReport];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:hasPendingCrashReport];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end
