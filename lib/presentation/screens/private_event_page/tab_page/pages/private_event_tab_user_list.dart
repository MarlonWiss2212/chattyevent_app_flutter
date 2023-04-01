import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_user_list/private_event_tab_user_list_detail.dart';

class PrivateEventTabUserList extends StatelessWidget {
  const PrivateEventTabUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Event User"),
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () => BlocProvider.of<CurrentPrivateEventCubit>(context)
              .getPrivateEventUsersViaApi(),
        ),
        const PrivateEventTabUserListDetail()
      ],
    );
  }
}
