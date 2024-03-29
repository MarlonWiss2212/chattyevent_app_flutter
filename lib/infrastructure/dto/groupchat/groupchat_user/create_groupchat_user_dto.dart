import 'package:chattyevent_app_flutter/infrastructure/dto/groupchat/groupchat_user/create_groupchat_user_from_create_groupchat_dto.dart';

class CreateGroupchatUserDto extends CreateGroupchatUserFromCreateGroupchatDto {
  final String groupchatTo;

  CreateGroupchatUserDto({
    required super.userId,
    required this.groupchatTo,
    super.role,
    super.usernameForChat,
  });

  @override
  Map toMap() {
    Map map = super.toMap();
    map.addAll({"groupchatTo": groupchatTo});
    return map;
  }
}
