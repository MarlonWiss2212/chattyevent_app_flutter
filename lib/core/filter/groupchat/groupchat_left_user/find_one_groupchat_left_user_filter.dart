import 'package:chattyevent_app_flutter/core/filter/groupchat/find_one_groupchat_to_filter.dart';

class FindGroupchatLeftUsersFilter extends FindOneGroupchatToFilter {
  final String userId;

  FindGroupchatLeftUsersFilter({
    required super.groupchatTo,
    required this.userId,
  });

  @override
  Map toMap() {
    final Map<dynamic, dynamic> map = super.toMap();
    map.addAll({"userId": userId});
    return map;
  }
}
