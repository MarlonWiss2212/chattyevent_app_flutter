import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/overwriting_standard/follow_data_entity.dart.dart';

class OverwritingStandardEntity {
  final OverwritingStandardFollowDataEntity? followData;

  OverwritingStandardEntity({this.followData});

  factory OverwritingStandardEntity.merge({
    required OverwritingStandardEntity newEntity,
    required OverwritingStandardEntity oldEntity,
  }) {
    return OverwritingStandardEntity(
      followData: newEntity.followData ?? oldEntity.followData,
    );
  }
}
