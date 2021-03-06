import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'rn-tester-library' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const RnTesterLibrary = NativeModules.RnTesterLibrary
  ? NativeModules.RnTesterLibrary
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export type AuthorizationStatus = "Unknown" |
  "Denied" |
  "Ephemeral" |
  "Authorized" |
  "Provisional" ;

export function getCurrentStatus(): Promise<AuthorizationStatus> {
  return RnTesterLibrary.getCurrentStatus();
}

export function askPermissions(): Promise<AuthorizationStatus> {
  return RnTesterLibrary.askPermissions();
}
