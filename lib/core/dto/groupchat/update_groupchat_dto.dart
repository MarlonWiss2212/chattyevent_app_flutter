import 'dart:io';

class UpdateGroupchatDto {
  final String? title;
  final String? description;
  final File? updateProfileImage;

  UpdateGroupchatDto({
    this.title,
    this.updateProfileImage,
    this.description,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {};

    if (title != null) {
      map.addAll({'title': title!});
    }
    if (description != null) {
      map.addAll({'description': description!});
    }

    return map;
  }
}
