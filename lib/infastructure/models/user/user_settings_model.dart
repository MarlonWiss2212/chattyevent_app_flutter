import 'package:chattyevent_app_flutter/domain/entities/user/on_accept_follow_request_standard_follow_data_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_settings_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/on_accept_follow_request_standard_follow_data_model.dart';

class UserSettingsModel extends UserSettingsEntity {
  UserSettingsModel({
    OnAcceptFollowRequestStandardFollowDataEntity?
        onAcceptFollowRequestStandardFollowData,
  }) : super(
          onAcceptFollowRequestStandardFollowData:
              onAcceptFollowRequestStandardFollowData,
        );

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      onAcceptFollowRequestStandardFollowData:
          json['onAcceptFollowRequestStandardFollowData'] != null
              ? OnAcceptFollowRequestStandardFollowDataModel.fromJson(
                  json['onAcceptFollowRequestStandardFollowData'],
                )
              : null,
    );
  }
}
