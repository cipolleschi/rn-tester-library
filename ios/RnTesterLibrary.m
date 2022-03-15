#import "RnTesterLibrary.h"

#import <UserNotifications/UNUserNotificationCenter.h>
#import <UserNotifications/UNNotificationSettings.h>

@implementation RnTesterLibrary

RCT_EXPORT_MODULE()
RCT_REMAP_METHOD(
                 getCurrentStatus,
                 getCurrentStatusWithResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject) {
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        switch (settings.authorizationStatus) {
            case UNAuthorizationStatusNotDetermined:
                resolve(@"Unknown");
                break;
            case UNAuthorizationStatusDenied:
                resolve(@"Denied");
                break;
            case UNAuthorizationStatusEphemeral:
                resolve(@"Ephemeral");
                break;
            case UNAuthorizationStatusAuthorized:
                resolve(@"Authorized");
                break;
            case UNAuthorizationStatusProvisional:
                resolve(@"Provisional");
                break;
        }
    }];
}


RCT_REMAP_METHOD(askPermissions,
                 askPermissionsWithResolver:(RCTPromiseResolveBlock)resolve
                                withRejecter:(RCTPromiseRejectBlock)reject)
{
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options =
        UNAuthorizationOptionAlert |
        UNAuthorizationOptionBadge |
        UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error != nil) {
            reject(@"Something went wrong", error.localizedDescription, nil);
            return;
        }

        [self getCurrentStatusWithResolver:resolve withRejecter:reject];
    }];
}


@end
