import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/private_event_list_item.dart';

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
                "Zukünftige Events",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () => BlocProvider.of<HomeEventCubit>(context)
                .getFuturePrivateEventsViaApi(reload: true),
          ),
          BlocBuilder<HomeEventCubit, HomeEventState>(
            builder: (context, state) {
              final futureEvents = state.getFutureEvents();
              if (state.loadingFutureEvents && futureEvents.isEmpty) {
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
                    if (index < futureEvents.length) {
                      return PrivateEventListItem(
                        privateEventState: futureEvents[index],
                      );
                    }

                    if (state.loadingFutureEvents) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<HomeEventCubit>(context)
                              .getFuturePrivateEventsViaApi();
                        },
                        icon: const Icon(Icons.add_circle),
                      );
                    }
                  },
                  childCount: futureEvents.length + 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
