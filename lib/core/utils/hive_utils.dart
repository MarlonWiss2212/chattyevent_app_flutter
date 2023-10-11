import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state_status.dart';
import 'package:chattyevent_app_flutter/core/utils/directory_utils.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/app_feature_introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/app_permission_introduction_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/introduction/introduction_entity.dart';
import 'package:hive/hive.dart';

class HiveUtils {
  static Future<void> initialize() async {
    final path = await DirectoryUtils.getApplicationDocumentsPath();
    Hive.init(path);
    Hive.registerAdapter(AuthStateAdapter());
    Hive.registerAdapter(AuthStateStatusAdapter());
    Hive.registerAdapter(IntroductionEntityAdapter());
    Hive.registerAdapter(AppFeatureIntroductionEntityAdapter());
    Hive.registerAdapter(AppPermissionIntroductionEntityAdapter());
  }

  static List<int> generateSecureKey() => Hive.generateSecureKey();
}
