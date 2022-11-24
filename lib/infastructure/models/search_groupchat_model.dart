class SearchGroupchatModel {
  final String id;
  final String title;
  final String description;

  SearchGroupchatModel(this.id, this.title, this.description);

  factory SearchGroupchatModel.fromJson(Map<String, dynamic> json) {
    return SearchGroupchatModel(
      json["_id"],
      json["title"],
      json["description"],
    );
  }
}
