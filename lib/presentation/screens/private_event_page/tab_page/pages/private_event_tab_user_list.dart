import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_users/private_event_tab_users_details.dart';

class PrivateEventTabUserList extends StatelessWidget {
  const PrivateEventTabUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "Event User",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () => BlocProvider.of<CurrentPrivateEventCubit>(context)
              .getPrivateEventUsersAndLeftUsersViaApi(),
        ),
        const PrivateEventTabUsersDetails()
      ],
    );
  }
}
