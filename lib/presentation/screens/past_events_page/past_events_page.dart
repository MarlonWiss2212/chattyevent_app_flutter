import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/private_event_list_item.dart';

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
              title: Text(
                "Vergangene Events",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () => BlocProvider.of<HomeEventCubit>(context)
                .getPastPrivateEventsViaApi(reload: true),
          ),
          BlocBuilder<HomeEventCubit, HomeEventState>(
            builder: (context, state) {
              if (state.loadingPastEvents == true &&
                  state.pastPrivateEvents.isEmpty) {
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
              } else if (state.pastPrivateEvents.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text("Keine Vergangenen Events")),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < state.pastPrivateEvents.length) {
                      return PrivateEventListItem(
                        privateEventState: state.pastPrivateEvents[index],
                      );
                    }
                    if (state.loadingPastEvents) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<HomeEventCubit>(context)
                              .getPastPrivateEventsViaApi();
                        },
                        icon: const Icon(Icons.add_circle),
                      );
                    }
                  },
                  childCount: state.pastPrivateEvents.length + 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
