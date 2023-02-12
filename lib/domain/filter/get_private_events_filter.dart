class GetPrivateEventsFilter {
  String connectedGroupchat;

  GetPrivateEventsFilter({required this.connectedGroupchat});

  Map<dynamic, dynamic> toMap() {
    return {"connectedGroupchat": connectedGroupchat};
  }
}
