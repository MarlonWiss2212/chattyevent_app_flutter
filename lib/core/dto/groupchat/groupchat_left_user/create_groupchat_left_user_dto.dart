import 'package:social_media_app_flutter/core/filter/groupchat/find_one_groupchat_to_filter.dart';

class CreateGroupchatLeftUserDto extends FindOneGroupchatToFilter {
  final String userId;

  CreateGroupchatLeftUserDto({
    required super.groupchatTo,
    required this.userId,
  });

  @override
  Map toMap() {
    Map<dynamic, dynamic> map = super.toMap();
    map.addAll({'userId': userId});
    return map;
  }
}
