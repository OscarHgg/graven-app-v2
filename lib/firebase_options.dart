// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
      return web;
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCBaX2wX_jzjliFlPWwBsplwNVL9eGkSw8',
    appId: '1:432551887665:web:06d503f531845a4512a610',
    messagingSenderId: '432551887665',
    projectId: 'graven-app-93b28',
    authDomain: 'graven-app-93b28.firebaseapp.com',
    storageBucket: 'graven-app-93b28.appspot.com',
    measurementId: 'G-RM6YYG4XPH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCiB89aKddT1f6jwUiDQ0UL3HGFI3DQF38',
    appId: '1:432551887665:android:071eb15886f9224c12a610',
    messagingSenderId: '432551887665',
    projectId: 'graven-app-93b28',
    storageBucket: 'graven-app-93b28.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2d0FJpYB5AF3qwMMU1nm7ZepYzFqy908',
    appId: '1:432551887665:ios:bdfad08e79c556ef12a610',
    messagingSenderId: '432551887665',
    projectId: 'graven-app-93b28',
    storageBucket: 'graven-app-93b28.appspot.com',
    iosClientId: '432551887665-bi3c9ekfgft2qdqgborb57t0m4jtirot.apps.googleusercontent.com',
    iosBundleId: 'com.graven.gravenV2App',
  );
}
