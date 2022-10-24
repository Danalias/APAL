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
    apiKey: 'AIzaSyB9_0HLQvSIBjlGOvS-ujh0iq11qBCAi7s',
    appId: '1:227631528080:web:8efa085f457ed0acbd0015',
    messagingSenderId: '227631528080',
    projectId: 'apal-e32b2',
    authDomain: 'apal-e32b2.firebaseapp.com',
    storageBucket: 'apal-e32b2.appspot.com',
    measurementId: 'G-JT18Y9V2ZH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOiFyeWcxmZkcz1BzEgk5GKiQ7iLGLqtA',
    appId: '1:227631528080:android:6362f3b816cd25c0bd0015',
    messagingSenderId: '227631528080',
    projectId: 'apal-e32b2',
    storageBucket: 'apal-e32b2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAejHSVxu4tcwYnlVvG8UgKY6ES4YOSXqM',
    appId: '1:227631528080:ios:c306be2499fc2636bd0015',
    messagingSenderId: '227631528080',
    projectId: 'apal-e32b2',
    storageBucket: 'apal-e32b2.appspot.com',
    iosClientId: '227631528080-jfv64p0c957dgghsqm0jakcjqtq9hkqn.apps.googleusercontent.com',
    iosBundleId: 'com.example.apal',
  );
}