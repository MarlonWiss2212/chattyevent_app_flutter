import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/create_groupchat_permissions_dto.dart';

class UpdateGroupchatPermissionsDto extends CreateGroupchatPermissionsDto {
  UpdateGroupchatPermissionsDto({
    super.addUsers,
    super.changeDescription,
    super.changeProfileImage,
    super.changeTitle,
    super.createEventForGroupchat,
  });
}
