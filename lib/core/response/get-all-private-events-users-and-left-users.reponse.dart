import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

class GetAllPrivateEventUsersAndLeftUsers {
  final List<PrivateEventUserEntity> privateEventUsers;
  final List<PrivateEventLeftUserEntity> privateEventLeftUsers;

  GetAllPrivateEventUsersAndLeftUsers({
    required this.privateEventUsers,
    required this.privateEventLeftUsers,
  });
}
