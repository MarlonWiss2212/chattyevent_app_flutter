class ChatMessageModel {
  final String id;
  final String message;
  final String createdBy;
  final String createdAt;

  ChatMessageModel(this.id, this.message, this.createdBy, this.createdAt);

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      json["_id"],
      json["message"],
      json["createdBy"],
      json["createdAt"],
    );
  }
}
