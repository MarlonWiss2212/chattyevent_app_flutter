import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';

class GroupchatLeftUserModel extends GroupchatLeftUserEntity {
  GroupchatLeftUserModel({
    required String id,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? leftGroupchatTo,
  }) : super(
          id: id,
          userId: userId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          leftGroupchatTo: leftGroupchatTo,
        );

  factory GroupchatLeftUserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;
    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return GroupchatLeftUserModel(
      id: json["_id"],
      userId: json['userId'],
      leftGroupchatTo: json['leftGroupchatTo'],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
