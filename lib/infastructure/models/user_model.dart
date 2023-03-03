import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String authId,
    String? username,
    String? email,
    String? firstname,
    String? lastname,
    String? emailVerified,
    String? profileImageLink,
    String? birthdate,
    String? lastTimeOnline,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          authId: authId,
          username: username,
          email: email,
          firstname: firstname,
          lastname: lastname,
          emailVerified: emailVerified,
          profileImageLink: profileImageLink,
          birthdate: birthdate,
          lastTimeOnline: lastTimeOnline,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json["createdAt"] != null
        ? DateTime.parse(json["createdAt"]).toLocal()
        : null;

    final updatedAt = json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"]).toLocal()
        : null;

    return UserModel(
      id: json['_id'],
      authId: json["authId"],
      username: json['username'],
      email: json['email'],
      profileImageLink: json['profileImageLink'],
      firstname: json["fistname"],
      lastname: json["lastname"],
      emailVerified: json["emailVerified"],
      birthdate: json["birthdate"],
      lastTimeOnline: json["lastTimeOnline"],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
