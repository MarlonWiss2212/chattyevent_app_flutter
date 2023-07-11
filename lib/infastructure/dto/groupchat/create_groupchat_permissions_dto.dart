import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';

class CreateGroupchatPermissionsDto {
  final GroupchatPermissionEnum? changeTitle;
  final GroupchatPermissionEnum? changeDescription;
  final GroupchatPermissionEnum? changeProfileImage;
  final GroupchatPermissionEnum? createEventForGroupchat;
  final GroupchatPermissionEnum? addUsers;

  CreateGroupchatPermissionsDto({
    this.addUsers,
    this.changeDescription,
    this.changeProfileImage,
    this.changeTitle,
    this.createEventForGroupchat,
  });

  CreateGroupchatPermissionsDto copyWith({
    GroupchatPermissionEnum? addUsers,
    GroupchatPermissionEnum? changeDescription,
    GroupchatPermissionEnum? changeProfileImage,
    GroupchatPermissionEnum? changeTitle,
    GroupchatPermissionEnum? createEventForGroupchat,
  }) {
    return CreateGroupchatPermissionsDto(
      changeDescription: changeDescription ?? this.changeDescription,
      changeProfileImage: changeProfileImage ?? this.changeProfileImage,
      changeTitle: changeTitle ?? this.changeTitle,
      createEventForGroupchat:
          createEventForGroupchat ?? this.createEventForGroupchat,
      addUsers: addUsers ?? this.addUsers,
    );
  }

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (changeDescription != null) {
      map.addAll({'changeDescription': changeDescription!.value});
    }
    if (changeProfileImage != null) {
      map.addAll({'changeProfileImage': changeProfileImage!.value});
    }
    if (changeTitle != null) {
      map.addAll({'changeTitle': changeTitle!.value});
    }
    if (createEventForGroupchat != null) {
      map.addAll({'createEventForGroupchat': createEventForGroupchat!.value});
    }
    if (addUsers != null) {
      map.addAll({'addUsers': addUsers!.value});
    }

    return map;
  }
}
