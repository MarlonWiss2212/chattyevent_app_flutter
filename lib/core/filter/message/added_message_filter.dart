import 'package:chattyevent_app_flutter/core/filter/groupchat/find_one_groupchat_to_filter.dart';

class AddedMessageFilter extends FindOneGroupchatToFilter {
  final bool? returnMyAddedMessageToo;

  AddedMessageFilter({
    required super.groupchatTo,
    this.returnMyAddedMessageToo,
  });

  @override
  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = super.toMap();
    if (returnMyAddedMessageToo != null) {
      map.addAll({"returnMyAddedMessageToo": returnMyAddedMessageToo});
    }
    return map;
  }
}
