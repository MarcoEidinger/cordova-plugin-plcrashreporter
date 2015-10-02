# cordova-plugin-plcrashreporter

## Description
Plugin is using PLCrashReporter to detect and load report from past application crash.

## Supported platforms
* iOS

## Install plugin

cordova plugin add https://github.com/MarcoEidinger/cordova-plugin-plcrashreporter.git

## Remove plugin

cordova plugin remove com.eidinger.cordova.plugin.crashlogger

## APPENDIX

### Setup cordova app

cordova create <not-existing directoryName> <reverse domain-style identifier> <application's display title>

cd <directoryName>

cordova platform add ios

cordova prepare

cordova build