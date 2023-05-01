import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/event_list/private_event_list_item.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_future_private_event_page/chat_future_private_event_page_skeleton_list.dart';

class ChatFuturePrivateEventsPage extends StatelessWidget {
  const ChatFuturePrivateEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentChatCubit>(context)
        .getFutureConnectedPrivateEventsFromApi(
      limitOffsetFilter: LimitOffsetFilter(
        limit: 100,
        offset: 0,
      ),
    );

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
              final privateEventLength =
                  BlocProvider.of<CurrentChatCubit>(context)
                      .state
                      .futureConnectedPrivateEvents
                      .length;

              return BlocProvider.of<CurrentChatCubit>(context)
                  .getFutureConnectedPrivateEventsFromApi(
                limitOffsetFilter: LimitOffsetFilter(
                  limit: privateEventLength > 10 ? privateEventLength : 10,
                  offset: 0,
                ),
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

              if (state.loadingPrivateEvents == false &&
                  state.futureConnectedPrivateEvents.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text("Keine Zukünftigen Events für den Chat"),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return PrivateEventListItem(
                      privateEventState: CurrentPrivateEventState(
                        privateEvent: state.futureConnectedPrivateEvents[index],
                        loadingGroupchat: false,
                        loadingPrivateEvent: false,
                        loadingShoppingList: false,
                        currentUserIndex: -1,
                        privateEventUsers: [],
                        privateEventLeftUsers: [],
                        shoppingListItemStates: [],
                      ),
                    );
                  },
                  childCount: state.futureConnectedPrivateEvents.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
