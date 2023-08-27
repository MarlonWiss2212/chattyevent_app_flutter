import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_list_item.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_future_private_event_page/chat_future_private_event_page_skeleton_list.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class GroupchatfutureEventsPage extends StatelessWidget {
  const GroupchatfutureEventsPage({super.key});

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
                )),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () {
              return BlocProvider.of<CurrentGroupchatCubit>(context)
                  .getFutureConnectedPrivateEventsFromApi(
                reload: true,
              );
            },
          ),
          BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
            builder: (context, state) {
              if (state.loadingPrivateEvents == true &&
                  state.futureConnectedPrivateEvents.isEmpty) {
                return const SliverFillRemaining(
                  child: ChatFuturePrivateEventPageSkeletonList(),
                );
              }

              if (state.loadingPrivateEvents == true &&
                  state.futureConnectedPrivateEvents.isEmpty) {
                return const SliverFillRemaining(
                  child: ChatFuturePrivateEventPageSkeletonList(),
                );
              } else if (state.futureConnectedPrivateEvents.isEmpty) {
                return const SliverFillRemaining(
                    child: Center(
                        child: Text(
                  "Keine Privaten Event für diesen Gruppenchat",
                )));
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < state.futureConnectedPrivateEvents.length) {
                      return EventListItem(
                        eventState: CurrentEventState.fromEvent(
                          event: state.futureConnectedPrivateEvents[index],
                        ),
                      );
                    }
                    if (state.loadingPrivateEvents) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<CurrentGroupchatCubit>(context)
                              .getFutureConnectedPrivateEventsFromApi();
                        },
                        icon: const Icon(Icons.add_circle),
                      );
                    }
                  },
                  childCount: state.futureConnectedPrivateEvents.length + 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
