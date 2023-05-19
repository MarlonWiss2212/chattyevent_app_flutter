import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/private_event_list_item.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_future_private_event_page/chat_future_private_event_page_skeleton_list.dart';

class ChatFuturePrivateEventsPage extends StatelessWidget {
  const ChatFuturePrivateEventsPage({super.key});

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
            flexibleSpace: FlexibleSpaceBar(
                title: Text(
              "Zukünftige Events",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            )),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () {
              return BlocProvider.of<CurrentChatCubit>(context)
                  .getFutureConnectedPrivateEventsFromApi(
                reload: true,
              );
            },
          ),
          BlocBuilder<CurrentChatCubit, CurrentChatState>(
            builder: (context, state) {
              if (state.loadingPrivateEvents == true &&
                  state.futureConnectedPrivateEvents.isEmpty) {
                return const SliverFillRemaining(
                  child: ChatFuturePrivateEventPageSkeletonList(),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < state.futureConnectedPrivateEvents.length) {
                      return PrivateEventListItem(
                        privateEventState: CurrentPrivateEventState(
                          privateEvent:
                              state.futureConnectedPrivateEvents[index],
                          loadingGroupchat: false,
                          loadingPrivateEvent: false,
                          loadingShoppingList: false,
                          currentUserIndex: -1,
                          privateEventUsers: [],
                          privateEventLeftUsers: [],
                          shoppingListItemStates: [],
                        ),
                      );
                    }
                    if (state.loadingPrivateEvents) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<CurrentChatCubit>(context)
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
