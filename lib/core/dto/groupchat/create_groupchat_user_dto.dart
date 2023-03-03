import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_user_from_create_groupchat_dto.dart';

class CreateGroupchatUserDto extends CreateGroupchatUserFromCreateGroupchatDto {
  String groupchatTo;

  CreateGroupchatUserDto({
    required super.authId,
    required this.groupchatTo,
    super.admin,
    super.usernameForChat,
  });

  @override
  Map toMap() {
    Map map = super.toMap();
    map.addAll({"groupchatTo": groupchatTo});
    return map;
  }
}
