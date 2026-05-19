import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDummyKey',
    appId: '1:1234567890:web:1234567890',
    messagingSenderId: '1234567890',
    projectId: 'kharis-investment',
    authDomain: 'kharis-investment.firebaseapp.com',
    storageBucket: 'kharis-investment.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDummyKey',
    appId: '1:1234567890:android:1234567890',
    messagingSenderId: '1234567890',
    projectId: 'kharis-investment',
    storageBucket: 'kharis-investment.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDummyKey',
    appId: '1:1234567890:ios:1234567890',
    messagingSenderId: '1234567890',
    projectId: 'kharis-investment',
    storageBucket: 'kharis-investment.appspot.com',
    iosBundleId: 'com.kharis.investment',
  );
}
