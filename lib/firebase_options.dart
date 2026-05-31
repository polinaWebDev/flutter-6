import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('платформа пока не настроена в firebase_options.dart');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'PLACEHOLDER_WEB_API_KEY',
    appId: 'PLACEHOLDER_WEB_APP_ID',
    messagingSenderId: 'PLACEHOLDER_SENDER_ID',
    projectId: 'PLACEHOLDER_PROJECT_ID',
    authDomain: 'PLACEHOLDER_PROJECT_ID.firebaseapp.com',
    storageBucket: 'PLACEHOLDER_PROJECT_ID.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmxtuv95-hy1RsKRrEp-CPUxc1q_vkE1o',
    appId: '1:87817673483:android:12cd57591091be8932200e',
    messagingSenderId: '87817673483',
    projectId: 'flutter-4755e',
    storageBucket: 'flutter-4755e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'PLACEHOLDER_IOS_API_KEY',
    appId: 'PLACEHOLDER_IOS_APP_ID',
    messagingSenderId: 'PLACEHOLDER_SENDER_ID',
    projectId: 'PLACEHOLDER_PROJECT_ID',
    storageBucket: 'PLACEHOLDER_PROJECT_ID.appspot.com',
    iosBundleId: 'com.example.flutter6',
  );
}