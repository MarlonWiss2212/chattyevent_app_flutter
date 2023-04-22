import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';

class GetAllPrivateEventData {
  final PrivateEventEntity privateEvent;
  final List<PrivateEventUserEntity> privateEventUsers;
  final List<PrivateEventLeftUserEntity> privateEventLeftUsers;

  GetAllPrivateEventData({
    required this.privateEvent,
    required this.privateEventUsers,
    required this.privateEventLeftUsers,
  });
}
