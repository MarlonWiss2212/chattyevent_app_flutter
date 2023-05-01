import 'package:social_media_app_flutter/core/filter/groupchat/find_one_groupchat_to_filter.dart';

class AddedGroupchatMessageFilter extends FindOneGroupchatToFilter {
  final bool? returnMyAddedMessageToo;

  AddedGroupchatMessageFilter({
    required super.groupchatTo,
    this.returnMyAddedMessageToo,
  });

  @override
  Map<dynamic, dynamic> toMap() {
    final Map<dynamic, dynamic> map = super.toMap();
    if (returnMyAddedMessageToo != null) {
      map.addAll({"returnMyAddedMessageToo": returnMyAddedMessageToo});
    }
    return map;
  }
}
