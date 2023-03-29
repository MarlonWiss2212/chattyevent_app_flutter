import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/event_list/private_event_list_item.dart';

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
          const SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(title: Text("Zukünftige Events")),
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
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return PrivateEventListItem(
                      privateEvent: state.futureConnectedPrivateEvents[index],
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
