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
    apiKey: 'AIzaSyD0Dkf13q4WoUCWVrPW9R8GuoVBHZ4zBQA',
    appId: '1:479188806184:web:90cda96a95af768bfc231d',
    messagingSenderId: '479188806184',
    projectId: 'e-commerce-app-knowledge',
    authDomain: 'e-commerce-app-knowledge.firebaseapp.com',
    storageBucket: 'e-commerce-app-knowledge.appspot.com',
    measurementId: 'G-XM75RME9WG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCC-8tInU5QZ291mqNlkwyU6xog6ALdLVs',
    appId: '1:479188806184:android:8d0acf436fd7a977fc231d',
    messagingSenderId: '479188806184',
    projectId: 'e-commerce-app-knowledge',
    storageBucket: 'e-commerce-app-knowledge.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyNK-fPxV4wB2HbEX6DgEIFbbjRoWu8WU',
    appId: '1:479188806184:ios:94cb8b55651511a5fc231d',
    messagingSenderId: '479188806184',
    projectId: 'e-commerce-app-knowledge',
    storageBucket: 'e-commerce-app-knowledge.appspot.com',
    iosBundleId: 'com.example.flutterEcommerceAppKnowledge',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDyNK-fPxV4wB2HbEX6DgEIFbbjRoWu8WU',
    appId: '1:479188806184:ios:ee4eb6215973a2affc231d',
    messagingSenderId: '479188806184',
    projectId: 'e-commerce-app-knowledge',
    storageBucket: 'e-commerce-app-knowledge.appspot.com',
    iosBundleId: 'com.example.flutterEcommerceAppKnowledge.RunnerTests',
  );
}