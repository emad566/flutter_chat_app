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
    apiKey: 'AIzaSyCAmlzCjxnpYOg46t2aydBLVtSCi4opvNI',
    appId: '1:363525251754:web:e8bd2c7d936c187f44e6d3',
    messagingSenderId: '363525251754',
    projectId: 'flutter-chat-app-7af32',
    authDomain: 'flutter-chat-app-7af32.firebaseapp.com',
    storageBucket: 'flutter-chat-app-7af32.appspot.com',
    measurementId: 'G-GX81TWR6F0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrgM9prZPehXrFK02NxBfVLkWVbF5q54g',
    appId: '1:363525251754:android:48bf42a15770d4e844e6d3',
    messagingSenderId: '363525251754',
    projectId: 'flutter-chat-app-7af32',
    storageBucket: 'flutter-chat-app-7af32.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqmAny4QGRW5BVxwzk1G9pnZVuduMcssc',
    appId: '1:363525251754:ios:4c1ad9cc628f0b1f44e6d3',
    messagingSenderId: '363525251754',
    projectId: 'flutter-chat-app-7af32',
    storageBucket: 'flutter-chat-app-7af32.appspot.com',
    iosClientId: '363525251754-e8d1fcuqcat56hitsu88fcp33percob7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqmAny4QGRW5BVxwzk1G9pnZVuduMcssc',
    appId: '1:363525251754:ios:4c1ad9cc628f0b1f44e6d3',
    messagingSenderId: '363525251754',
    projectId: 'flutter-chat-app-7af32',
    storageBucket: 'flutter-chat-app-7af32.appspot.com',
    iosClientId: '363525251754-e8d1fcuqcat56hitsu88fcp33percob7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterChatApp',
  );
}
