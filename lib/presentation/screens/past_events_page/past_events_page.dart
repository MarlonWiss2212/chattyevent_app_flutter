import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_list_item.dart';

@RoutePage()
class PastEventsPage extends StatelessWidget {
  const PastEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Text(
                "pastEventPage.title",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ).tr(),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () => BlocProvider.of<HomeEventCubit>(context)
                .getPastEventsViaApi(reload: true),
          ),
          BlocBuilder<HomeEventCubit, HomeEventState>(
            builder: (context, state) {
              if (state.loadingPastEvents == true && state.pastEvents.isEmpty) {
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
              } else if (state.pastEvents.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: const Text("pastEventsPage.noPastEventsText").tr(),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < state.pastEvents.length) {
                      return EventListItem(
                        eventState: state.pastEvents[index],
                      );
                    }
                    if (state.loadingPastEvents) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<HomeEventCubit>(context)
                              .getPastEventsViaApi();
                        },
                        icon: const Icon(Ionicons.arrow_down_circle_outline),
                      );
                    }
                  },
                  childCount: state.pastEvents.length + 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
