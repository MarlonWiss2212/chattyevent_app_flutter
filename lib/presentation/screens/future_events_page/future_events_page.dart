import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_list_item.dart';

@RoutePage()
class FutureEventsPage extends StatelessWidget {
  const FutureEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            centerTitle: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "futureEventPage.title",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ).tr(),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () => BlocProvider.of<HomeEventCubit>(context)
                .getfutureEventsViaApi(reload: true),
          ),
          BlocBuilder<HomeEventCubit, HomeEventState>(
            builder: (context, state) {
              if (state.loadingFutureEvents && state.futureEvents.isEmpty) {
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
              } else if (state.futureEvents.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                      child: Text("futureEventPage.noFutureEventsText").tr()),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < state.futureEvents.length) {
                      return EventListItem(
                        eventState: state.futureEvents[index],
                      );
                    }

                    if (state.loadingFutureEvents) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<HomeEventCubit>(context)
                              .getfutureEventsViaApi();
                        },
                        icon: const Icon(Icons.add_circle),
                      );
                    }
                  },
                  childCount: state.futureEvents.length + 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
