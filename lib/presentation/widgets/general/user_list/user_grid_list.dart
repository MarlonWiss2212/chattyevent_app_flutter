import 'dart:math';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_grid_list_item.dart';

class UserGridList extends StatefulWidget {
  final List<UserEntity> users;
  final Function(UserEntity user)? onLongPress;
  final Function(UserEntity user)? onPress;
  final Widget Function(UserEntity user)? button;
  final void Function()? loadMore;
  final bool loading;

  const UserGridList({
    super.key,
    required this.users,
    this.button,
    this.onLongPress,
    this.onPress,
    this.loadMore,
    this.loading = false,
  });

  @override
  State<UserGridList> createState() => _UserGridListState();
}

class _UserGridListState extends State<UserGridList> {
  /*late ScrollController _scrollController;

 / @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter <= 0 &&
        widget.loading == false &&
        widget.loadMore != null) {
      widget.loadMore!();
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //    controller: _scrollController,
      itemBuilder: (context, index) {
        //  if (index < widget.users.length) {
        return UserGridListItem(
          user: widget.users[index],
          button: widget.button != null
              ? widget.button!(widget.users[index])
              : null,
          onLongPress: widget.onLongPress == null
              ? null
              : () => widget.onLongPress!(widget.users[index]),
          onPress: widget.onPress == null
              ? null
              : () => widget.onPress!(widget.users[index]),
        );
        // }
        //  return const CircularProgressIndicator.adaptive();
      },
      itemCount: /* widget.loading ? widget.users.length + 1 :*/
          widget.users.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: max(
          (MediaQuery.of(context).size.width ~/ 150).toInt(),
          1,
        ),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
    );
  }
}
