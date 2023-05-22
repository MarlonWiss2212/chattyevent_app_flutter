import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/before_create_standard_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/on_accept_standard_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/overwriting_standard_entity.dart';

class UserSettingsEntity {
  final OnAcceptStandardEntity? onAcceptStandard;
  final BeforeCreateStandardEntity? beforeCreateStandard;
  final OverwritingStandardEntity? overwritingStandard;

  UserSettingsEntity({
    this.onAcceptStandard,
    this.beforeCreateStandard,
    this.overwritingStandard,
  });

  factory UserSettingsEntity.merge({
    required UserSettingsEntity newEntity,
    required UserSettingsEntity oldEntity,
  }) {
    return UserSettingsEntity(
      onAcceptStandard:
          newEntity.onAcceptStandard ?? oldEntity.onAcceptStandard,
      overwritingStandard:
          newEntity.overwritingStandard ?? oldEntity.overwritingStandard,
      beforeCreateStandard:
          newEntity.beforeCreateStandard ?? oldEntity.beforeCreateStandard,
    );
  }
}
