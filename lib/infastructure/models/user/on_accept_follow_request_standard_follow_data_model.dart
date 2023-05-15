import 'package:chattyevent_app_flutter/domain/entities/user/on_accept_follow_request_standard_follow_data_entity.dart';

class OnAcceptFollowRequestStandardFollowDataModel
    extends OnAcceptFollowRequestStandardFollowDataEntity {
  OnAcceptFollowRequestStandardFollowDataModel({
    String? standardRequesterPrivateEventAddPermission,
    String? standardRequesterGroupchatAddPermission,
  }) : super(
          standardRequesterGroupchatAddPermission:
              standardRequesterGroupchatAddPermission,
          standardRequesterPrivateEventAddPermission:
              standardRequesterPrivateEventAddPermission,
        );

  factory OnAcceptFollowRequestStandardFollowDataModel.fromJson(
      Map<String, dynamic> json) {
    return OnAcceptFollowRequestStandardFollowDataModel(
      standardRequesterGroupchatAddPermission:
          json['standardRequesterGroupchatAddPermission'],
      standardRequesterPrivateEventAddPermission:
          json['standardRequesterPrivateEventAddPermission'],
    );
  }
}
