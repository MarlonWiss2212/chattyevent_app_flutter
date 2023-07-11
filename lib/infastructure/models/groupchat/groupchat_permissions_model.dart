import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_permissions_entity.dart';

class GroupchatPermissionsModel extends GroupchatPermissionsEntity {
  GroupchatPermissionsModel({
    super.changeProfileImage,
    super.changeDescription,
    super.changeTitle,
    super.createEventForGroupchat,
    super.addUsers,
  });

  factory GroupchatPermissionsModel.fromJson(Map<String, dynamic> json) {
    return GroupchatPermissionsModel(
      changeDescription: json["changeDescription"] != null
          ? GroupchatPermissionEnumExtension.fromValue(
              json["changeDescription"])
          : null,
      changeProfileImage: json["changeProfileImage"] != null
          ? GroupchatPermissionEnumExtension.fromValue(
              json["changeProfileImage"])
          : null,
      changeTitle: json["changeTitle"] != null
          ? GroupchatPermissionEnumExtension.fromValue(json["changeTitle"])
          : null,
      createEventForGroupchat: json["createEventForGroupchat"] != null
          ? GroupchatPermissionEnumExtension.fromValue(
              json["createEventForGroupchat"])
          : null,
      addUsers: json["addUsers"] != null
          ? GroupchatPermissionEnumExtension.fromValue(json["addUsers"])
          : null,
    );
  }
}
