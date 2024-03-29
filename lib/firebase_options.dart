// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-whM0ePdmNvxsbOaT90ZECOeX2ZcrZMc',
    appId: '1:24235156039:android:7cb33bae009c3eaf444762',
    messagingSenderId: '24235156039',
    projectId: 'nfcmobileapp-main',
    databaseURL: 'https://nfcmobileapp-main-default-rtdb.firebaseio.com',
    storageBucket: 'nfcmobileapp-main.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbLfAsbJHGhas4KjxrtKAk8NgPkeX8BiE',
    appId: '1:24235156039:ios:69ec7e586e467338444762',
    messagingSenderId: '24235156039',
    projectId: 'nfcmobileapp-main',
    databaseURL: 'https://nfcmobileapp-main-default-rtdb.firebaseio.com',
    storageBucket: 'nfcmobileapp-main.appspot.com',
    iosClientId: '24235156039-1ropfm3bkv5ooov2e6l454c9rg9blebg.apps.googleusercontent.com',
    iosBundleId: 'com.naokiokada.nfcmanager',
  );
}
