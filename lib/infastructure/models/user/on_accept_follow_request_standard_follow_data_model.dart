import 'package:chattyevent_app_flutter/domain/entities/user/on_accept_follow_request_standard_follow_data_entity.dart';

class OnAcceptFollowRequestStandardFollowDataModel
    extends OnAcceptFollowRequestStandardFollowDataEntity {
  OnAcceptFollowRequestStandardFollowDataModel({
    String? standardFollowedToPrivateEventPermission,
    String? standardFollowedToGroupchatPermission,
  }) : super(
          standardFollowedToGroupchatPermission:
              standardFollowedToGroupchatPermission,
          standardFollowedToPrivateEventPermission:
              standardFollowedToPrivateEventPermission,
        );

  factory OnAcceptFollowRequestStandardFollowDataModel.fromJson(
      Map<String, dynamic> json) {
    return OnAcceptFollowRequestStandardFollowDataModel(
      standardFollowedToGroupchatPermission:
          json['standardFollowedToGroupchatPermission'],
      standardFollowedToPrivateEventPermission:
          json['standardFollowedToPrivateEventPermission'],
    );
  }
}
