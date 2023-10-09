import 'package:chattyevent_app_flutter/core/utils/directory_utils.dart';
import 'package:hive/hive.dart';

class HiveUtils {
  static Future<void> initialize() async => Hive.init(
        await DirectoryUtils.getApplicationDocumentsPath(),
      );
  static List<int> generateSecureKey() => Hive.generateSecureKey();
}
