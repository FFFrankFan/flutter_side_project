// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCQFf70s9G1F3NC2bD-c_N4B_iZZyuXx_g',
    appId: '1:1036663667129:web:801584e2e93855ad751e68',
    messagingSenderId: '1036663667129',
    projectId: 'frank-side-project',
    authDomain: 'frank-side-project.firebaseapp.com',
    storageBucket: 'frank-side-project.appspot.com',
    measurementId: 'G-Y0MXLBFQBT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCftbGMbHtpQ9LMQ3P-UP_KNNXPo1NnM3M',
    appId: '1:1036663667129:android:e46e3d633f18f3b2751e68',
    messagingSenderId: '1036663667129',
    projectId: 'frank-side-project',
    storageBucket: 'frank-side-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNYz6P7yoPKSpA_0KKWYLjeSqMo45nTgM',
    appId: '1:1036663667129:ios:249c474b2ebe36ce751e68',
    messagingSenderId: '1036663667129',
    projectId: 'frank-side-project',
    storageBucket: 'frank-side-project.appspot.com',
    iosBundleId: 'com.example.flutterProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNYz6P7yoPKSpA_0KKWYLjeSqMo45nTgM',
    appId: '1:1036663667129:ios:249c474b2ebe36ce751e68',
    messagingSenderId: '1036663667129',
    projectId: 'frank-side-project',
    storageBucket: 'frank-side-project.appspot.com',
    iosBundleId: 'com.example.flutterProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCQFf70s9G1F3NC2bD-c_N4B_iZZyuXx_g',
    appId: '1:1036663667129:web:244ca594a670e0f2751e68',
    messagingSenderId: '1036663667129',
    projectId: 'frank-side-project',
    authDomain: 'frank-side-project.firebaseapp.com',
    storageBucket: 'frank-side-project.appspot.com',
    measurementId: 'G-0CHF33ETNQ',
  );
}
