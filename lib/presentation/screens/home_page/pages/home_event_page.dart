import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/event_list/event_horizontal_list_skeleton.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/home_page/pages/home_event_page/home_event_page_details.dart';

class HomeEventPage extends StatelessWidget {
  const HomeEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PrivateEventCubit>(context).getPrivateEventsViaApi();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Events"),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => AutoRouter.of(context).push(
                  const NewPrivateEventPageRoute(),
                ),
              ),
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: BlocProvider.of<PrivateEventCubit>(context)
                .getPrivateEventsViaApi,
          ),
          BlocBuilder<PrivateEventCubit, PrivateEventState>(
            builder: (context, state) {
              if (state.privateEvents.isEmpty &&
                  state.status != PrivateEventStateStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(child: Text("Keine Privaten Events")),
                );
              }

              if (state.privateEvents.isEmpty &&
                  state.status == PrivateEventStateStatus.loading) {
                return const EventHorizontalListSkeleton();
              }

              return HomeEventPageDetails(
                privateEvents: state.privateEvents,
              );
            },
          ),
        ],
      ),
    );
  }
}
