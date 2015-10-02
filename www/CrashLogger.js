/**
 * This represents the mobile device, and provides properties for inspecting the model, version, UUID of the
 * phone, etc.
 * @constructor
 */
function CrashLogger() {
//     this.available = false;
//     this.platform = null;
//     this.version = null;
//     this.uuid = null;
//     this.cordova = null;
//     this.model = null;
//     this.manufacturer = null;
// 
//     var me = this;
// 
//     channel.onCordovaReady.subscribe(function() {
//         me.getInfo(function(info) {
//             //ignoring info.cordova returning from native, we should use value from cordova.version defined in cordova.js
//             //TODO: CB-5105 native implementations should not return info.cordova
//             var buildLabel = cordova.version;
//             me.available = true;
//             me.platform = info.platform;
//             me.version = info.version;
//             me.uuid = info.uuid;
//             me.cordova = buildLabel;
//             me.model = info.model;
//             me.manufacturer = info.manufacturer || 'unknown';
//             channel.onCordovaInfoReady.fire();
//         },function(e) {
//             me.available = false;
//             utils.alert("[ERROR] Error initializing Cordova: " + e);
//         });
//     });
}

CrashLogger.prototype.initialize = function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, "CrashLogger", "initialize", []);
};


CrashLogger.prototype.hasPendingCrashReport = function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, "CrashLogger", "hasPendingCrashReport", []);
};

CrashLogger.prototype.loadPendingCrashReport = function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, "CrashLogger", "loadPendingCrashReport", []);
};

CrashLogger.prototype.purgePendingCrashReport = function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, "CrashLogger", "purgePendingCrashReport", []);
};

module.exports = new CrashLogger();