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
    apiKey: 'AIzaSyC7LXfxlzQhWmJmJjlFFOZas3aQtTgU4mY',
    appId: '1:410244883334:web:fc69c3f028a6e4befb8207',
    messagingSenderId: '410244883334',
    projectId: 'flash-chat-15c17',
    authDomain: 'flash-chat-15c17.firebaseapp.com',
    storageBucket: 'flash-chat-15c17.appspot.com',
    measurementId: 'G-ZM8PVMYXMJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlGaNWW66wmGYo7K9DAHiPWUzZfMNMrs8',
    appId: '1:410244883334:android:0848eddce2be4244fb8207',
    messagingSenderId: '410244883334',
    projectId: 'flash-chat-15c17',
    storageBucket: 'flash-chat-15c17.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdqgXJAIaZlN3uExVj8SBcbC3gE6Nfmcw',
    appId: '1:410244883334:ios:e26dc559af51d15cfb8207',
    messagingSenderId: '410244883334',
    projectId: 'flash-chat-15c17',
    storageBucket: 'flash-chat-15c17.appspot.com',
    iosBundleId: 'com.example.flashchat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdqgXJAIaZlN3uExVj8SBcbC3gE6Nfmcw',
    appId: '1:410244883334:ios:e26dc559af51d15cfb8207',
    messagingSenderId: '410244883334',
    projectId: 'flash-chat-15c17',
    storageBucket: 'flash-chat-15c17.appspot.com',
    iosBundleId: 'com.example.flashchat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC7LXfxlzQhWmJmJjlFFOZas3aQtTgU4mY',
    appId: '1:410244883334:web:d7ed937f9be9370ffb8207',
    messagingSenderId: '410244883334',
    projectId: 'flash-chat-15c17',
    authDomain: 'flash-chat-15c17.firebaseapp.com',
    storageBucket: 'flash-chat-15c17.appspot.com',
    measurementId: 'G-0TYWQD3P31',
  );
}
