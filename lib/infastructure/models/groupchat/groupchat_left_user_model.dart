import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';

class GroupchatLeftUserModel extends GroupchatLeftUserEntity {
  GroupchatLeftUserModel({
    required String userId,
    DateTime? leftAt,
  }) : super(
          userId: userId,
          leftAt: leftAt,
        );

  factory GroupchatLeftUserModel.fromJson(Map<String, dynamic> json) {
    final leftAt = json["leftAt"] != null
        ? DateTime.parse(json["leftAt"]).toLocal()
        : null;
    return GroupchatLeftUserModel(
      userId: json['userId'],
      leftAt: leftAt,
    );
  }
}
