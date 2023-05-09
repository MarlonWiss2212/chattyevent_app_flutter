import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class WeblinkDatasource {
  Future<bool> launchUrl({
    required String url,
    bool otherApp = false,
  });
}

class WeblinkDatasourceImpl implements WeblinkDatasource {
  @override
  Future<bool> launchUrl({
    required String url,
    bool otherApp = false,
  }) async {
    final LaunchMode mode = !kIsWeb
        ? otherApp && Platform.isAndroid || Platform.isIOS
            ? LaunchMode.externalApplication
            : LaunchMode.platformDefault
        : LaunchMode.platformDefault;
    return await launchUrlString(url, mode: mode);
  }
}
