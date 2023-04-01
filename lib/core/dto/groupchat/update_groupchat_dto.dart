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
    Map<dynamic, dynamic> variables = {};

    if (title != null) {
      variables.addAll({'title': title!});
    }
    if (description != null) {
      variables.addAll({'description': description!});
    }

    return variables;
  }
}
