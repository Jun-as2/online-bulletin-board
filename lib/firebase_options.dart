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
    apiKey: 'AIzaSyB5zFGU4G8Q13OkpkKA4TBG7sc3KA4hrv8',
    appId: '1:246551533085:web:0b24aef54dc90dd3e1d8f4',
    messagingSenderId: '246551533085',
    projectId: 'online-bulletin-board',
    authDomain: 'online-bulletin-board.firebaseapp.com',
    storageBucket: 'online-bulletin-board.appspot.com',
    measurementId: 'G-XRVVNEET10',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2YCvSj4unUZtAnuEfWs0Ki1uBoPAwndw',
    appId: '1:246551533085:android:986b3b8ec0f68fc7e1d8f4',
    messagingSenderId: '246551533085',
    projectId: 'online-bulletin-board',
    storageBucket: 'online-bulletin-board.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOq5bq1PqUc0m9PcusX9x_U6OS7rc8J2M',
    appId: '1:246551533085:ios:f8f06af7e878b73de1d8f4',
    messagingSenderId: '246551533085',
    projectId: 'online-bulletin-board',
    storageBucket: 'online-bulletin-board.appspot.com',
    iosBundleId: 'com.example.onlineBulletinBoard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOq5bq1PqUc0m9PcusX9x_U6OS7rc8J2M',
    appId: '1:246551533085:ios:f8f06af7e878b73de1d8f4',
    messagingSenderId: '246551533085',
    projectId: 'online-bulletin-board',
    storageBucket: 'online-bulletin-board.appspot.com',
    iosBundleId: 'com.example.onlineBulletinBoard',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB5zFGU4G8Q13OkpkKA4TBG7sc3KA4hrv8',
    appId: '1:246551533085:web:68b3f4533e4410a0e1d8f4',
    messagingSenderId: '246551533085',
    projectId: 'online-bulletin-board',
    authDomain: 'online-bulletin-board.firebaseapp.com',
    storageBucket: 'online-bulletin-board.appspot.com',
    measurementId: 'G-3FH8VLN77D',
  );
}
