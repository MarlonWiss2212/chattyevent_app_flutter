class SearchPrivateEventModel {
  final String id;
  final String title;
  final String? coverImageLink;

  SearchPrivateEventModel(this.id, this.title, this.coverImageLink);

  factory SearchPrivateEventModel.fromJson(Map<String, dynamic> json) {
    return SearchPrivateEventModel(
      json["_id"],
      json["title"],
      json["coverImageLink"],
    );
  }
}
