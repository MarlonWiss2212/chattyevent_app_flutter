import 'dart:io';

class AdHelper {
  static String get chatListBannerAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-6709565406365779/3106308129';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6709565406365779/8430384700';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get mapTabBannerAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-6709565406365779/8022758731';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6709565406365779/7756477534';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get privateEventListBannerAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-6709565406365779/5396595394';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6709565406365779/4008804214';
    }
    throw UnsupportedError("Unsupported platform");
  }
}
