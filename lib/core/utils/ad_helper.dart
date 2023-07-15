import 'dart:io';

class AdHelper {
  static String get chatListNativeAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-6709565406365779/4889214965';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6709565406365779/3959276679';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get mapTabNativeAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-6709565406365779/5938572755';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6709565406365779/2646195003';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get privateEventListNativeAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-6709565406365779/6572997574';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6709565406365779/9020031663';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get discoverPAgeNativeAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-6709565406365779/6815317334';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6709565406365779/7374554681';
    }
    throw UnsupportedError("Unsupported platform");
  }
}
