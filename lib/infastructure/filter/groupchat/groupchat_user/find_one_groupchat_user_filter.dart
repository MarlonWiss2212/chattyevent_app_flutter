import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_to_filter.dart';

class FindOneGroupchatUserFilter extends FindOneGroupchatToFilter {
  final String userId;

  FindOneGroupchatUserFilter({
    required this.userId,
    required super.groupchatTo,
  });

  @override
  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> map = super.toMap();
    map.addAll({"userId": userId});
    return map;
  }
}
