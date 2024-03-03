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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCnFCILiP2ovR_A4TGx19RAkJZB5G2M0Ng',
    appId: '1:233051706951:web:44a2ed758f600f90784362',
    messagingSenderId: '233051706951',
    projectId: 'foodapp-11910',
    authDomain: 'foodapp-11910.firebaseapp.com',
    storageBucket: 'foodapp-11910.appspot.com',
    measurementId: 'G-9YCS8L4JNY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA25UqktWD6E_vXu9ZrNHX_wibSvws3ZSc',
    appId: '1:233051706951:android:b695b0b4f02d80ed784362',
    messagingSenderId: '233051706951',
    projectId: 'foodapp-11910',
    storageBucket: 'foodapp-11910.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmPyJgtgtp9ruLkQs1jIcApwbX9P9wFYs',
    appId: '1:233051706951:ios:a36d3000630a4158784362',
    messagingSenderId: '233051706951',
    projectId: 'foodapp-11910',
    storageBucket: 'foodapp-11910.appspot.com',
    iosBundleId: 'com.example.foodapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmPyJgtgtp9ruLkQs1jIcApwbX9P9wFYs',
    appId: '1:233051706951:ios:2beeb2f5f63bec84784362',
    messagingSenderId: '233051706951',
    projectId: 'foodapp-11910',
    storageBucket: 'foodapp-11910.appspot.com',
    iosBundleId: 'com.example.foodapp.RunnerTests',
  );
}
