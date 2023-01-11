import 'dart:io';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class CreatePrivateEventDto {
  String title;
  File coverImage;
  String connectedGroupchat;
  DateTime eventDate;

  CreatePrivateEventDto({
    required this.title,
    required this.coverImage,
    required this.connectedGroupchat,
    required this.eventDate,
  });

  Future<Map<dynamic, dynamic>> toMap() async {
    final multipartFile = await MultipartFile.fromPath(
      'photo',
      coverImage.path,
      filename: '$title.jpg',
      contentType: MediaType("image", "jpg"),
    );

    return {
      'title': title,
      'coverImage': multipartFile,
      'connectedGroupchat': connectedGroupchat,
      'eventDate': eventDate.toIso8601String(),
    };
  }
}
