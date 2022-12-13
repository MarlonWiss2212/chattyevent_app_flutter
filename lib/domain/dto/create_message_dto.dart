class CreateMessageDto {
  String message;
  String? fileLink;
  String groupchatTo;
  String? messageToReactTo;

  CreateMessageDto({
    required this.message,
    this.fileLink,
    required this.groupchatTo,
    this.messageToReactTo,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'message': message,
      'fileLink': fileLink,
      'groupchatTo': groupchatTo,
      'messageToReactTo': messageToReactTo,
    };
  }
}
