// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android();
      case TargetPlatform.iOS:
        return ios();
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS - '
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

  static FirebaseOptions android() {
    return FirebaseOptions(
      apiKey: dotenv.get("FIREBASE_API_KEY_ANDROID"),
      appId: dotenv.get("FIREBASE_ANDROID_APP_ID"),
      messagingSenderId: dotenv.get("FIREBASE_MESSAGING_SENDER_ID"),
      projectId: dotenv.get("FIREBASE_PROJECT_ID"),
      storageBucket: dotenv.get("FIREBASE_STORAGE_BUCKET"),
    );
  }

  static FirebaseOptions ios() {
    return FirebaseOptions(
      apiKey: dotenv.get("FIREBASE_API_KEY_IOS"),
      appId: dotenv.get("FIREBASE_IOS_APP_ID"),
      messagingSenderId: dotenv.get("FIREBASE_MESSAGING_SENDER_ID"),
      projectId: dotenv.get("FIREBASE_PROJECT_ID"),
      storageBucket: dotenv.get("FIREBASE_STORAGE_BUCKET"),
      iosClientId: dotenv.get("FIREBASE_CLIENT_ID_IOS"),
      iosBundleId: 'com.chattyevent.chattyevent',
    );
  }
}
