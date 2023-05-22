import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_settings_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_settings_entity.dart';

class BeforeCreateStandardEntity {
  final GroupchatSettingsEntity? groupchatSettings;
  final PrivateEventSettingsEntity? privateEventSettings;

  BeforeCreateStandardEntity({
    this.groupchatSettings,
    this.privateEventSettings,
  });

  factory BeforeCreateStandardEntity.merge({
    required BeforeCreateStandardEntity newEntity,
    required BeforeCreateStandardEntity oldEntity,
  }) {
    return BeforeCreateStandardEntity(
      groupchatSettings:
          newEntity.groupchatSettings ?? oldEntity.groupchatSettings,
      privateEventSettings:
          newEntity.privateEventSettings ?? oldEntity.privateEventSettings,
    );
  }
}
