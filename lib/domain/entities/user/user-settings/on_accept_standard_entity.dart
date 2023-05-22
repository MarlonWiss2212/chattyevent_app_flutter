import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/on_accept_standard/follow_data_entity.dart';

class OnAcceptStandardEntity {
  final OnAcceptStandardFollowDataEntity? followData;

  OnAcceptStandardEntity({this.followData});

  factory OnAcceptStandardEntity.merge({
    required OnAcceptStandardEntity newEntity,
    required OnAcceptStandardEntity oldEntity,
  }) {
    return OnAcceptStandardEntity(
      followData: newEntity.followData ?? oldEntity.followData,
    );
  }
}
