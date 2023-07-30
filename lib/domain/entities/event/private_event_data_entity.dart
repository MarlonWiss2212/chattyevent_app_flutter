class PrivateEventDataEntity {
  final String? groupchatTo;

  PrivateEventDataEntity({this.groupchatTo});

  factory PrivateEventDataEntity.merge({
    required PrivateEventDataEntity newEntity,
    required PrivateEventDataEntity oldEntity,
  }) {
    return PrivateEventDataEntity(
      groupchatTo: newEntity.groupchatTo ?? oldEntity.groupchatTo,
    );
  }
}
