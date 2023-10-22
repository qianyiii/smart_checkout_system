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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCuRiIwBaFBGBsWdmAY-YrWxCFqaHJ8iIw',
    appId: '1:758106473796:web:36aee903ea24947e458311',
    messagingSenderId: '758106473796',
    projectId: 'smart-checkout-c03cc',
    authDomain: 'smart-checkout-c03cc.firebaseapp.com',
    storageBucket: 'smart-checkout-c03cc.appspot.com',
    measurementId: 'G-P0NHX0126T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgWNor0PmDQkHXefXMh017uIzbdRlMe8A',
    appId: '1:758106473796:android:e88122da7e5093d4458311',
    messagingSenderId: '758106473796',
    projectId: 'smart-checkout-c03cc',
    storageBucket: 'smart-checkout-c03cc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyfI4tDHVSP7YDmSQpNBWf8PRgjWroOr0',
    appId: '1:758106473796:ios:4f2dfdb364dbbeb7458311',
    messagingSenderId: '758106473796',
    projectId: 'smart-checkout-c03cc',
    storageBucket: 'smart-checkout-c03cc.appspot.com',
    iosBundleId: 'com.qianyi.smartCheckoutSystem',
  );
}