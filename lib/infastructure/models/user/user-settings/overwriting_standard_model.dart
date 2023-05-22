import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/overwriting_standard_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user-settings/overwriting_standard/follow_data_model.dart';

class OverwritingStandardModel extends OverwritingStandardEntity {
  OverwritingStandardModel({super.followData});

  factory OverwritingStandardModel.fromJson(Map<String, dynamic> json) {
    return OverwritingStandardModel(
      followData: json['followData'] != null
          ? OverwritingStandardFollowDataModel.fromJson(
              json['followData'],
            )
          : null,
    );
  }
}
