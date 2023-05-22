import 'package:chattyevent_app_flutter/core/enums/user/requester_calender_watch_overwriting_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user/requester_groupchat_add_overwriting_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user/requester_private_event_add_overwriting_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user-settings/overwriting_standard/follow_data_entity.dart.dart';

class OverwritingStandardFollowDataModel
    extends OverwritingStandardFollowDataEntity {
  OverwritingStandardFollowDataModel({
    super.requesterPrivateEventAddPermission,
    super.requesterGroupchatAddPermission,
    super.requesterCalenderWatchPermission,
  });

  factory OverwritingStandardFollowDataModel.fromJson(
      Map<String, dynamic> json) {
    return OverwritingStandardFollowDataModel(
      requesterGroupchatAddPermission: json[
                  'requesterGroupchatAddPermission'] !=
              null
          ? RequesterGroupchatAddOverwritingPermissionEnumExtension.fromValue(
              json['requesterGroupchatAddPermission'],
            )
          : null,
      requesterCalenderWatchPermission: json[
                  'requesterCalenderWatchPermission'] !=
              null
          ? RequesterCalenderWatchOverwritingPermissionEnumExtension.fromValue(
              json['requesterCalenderWatchPermission'],
            )
          : null,
      requesterPrivateEventAddPermission:
          json['requesterPrivateEventAddPermission'] != null
              ? RequesterPrivateEventAddOverwritingPermissionEnumExtension
                  .fromValue(
                  json['requesterPrivateEventAddPermission'],
                )
              : null,
    );
  }
}
