import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/event_list/private_event_list_item.dart';

class FutureEventsPage extends StatelessWidget {
  const FutureEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Zukünftige Events"),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () => BlocProvider.of<HomeEventCubit>(context)
                .getFuturePrivateEventsViaApi(reload: true),
          ),
          BlocBuilder<HomeEventCubit, HomeEventState>(
            builder: (context, state) {
              final futureEvents = state.getFutureEvents();
              if (state.status == HomeEventStateStatus.loading &&
                  futureEvents.isEmpty) {
                return SliverFillRemaining(
                  child: SkeletonListView(
                    itemBuilder: (p0, p1) {
                      return SkeletonListTile(
                        hasSubtitle: true,
                        hasLeading: false,
                        titleStyle: const SkeletonLineStyle(
                          width: double.infinity,
                          height: 22,
                        ),
                        subtitleStyle: const SkeletonLineStyle(
                          width: double.infinity,
                          height: 16,
                        ),
                      );
                    },
                  ),
                );
              } else if (futureEvents.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text("Keine Zukünftigen Events")),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return PrivateEventListItem(
                      privateEvent: futureEvents[index],
                    );
                  },
                  childCount: futureEvents.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}