import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_list/chat_grid_list.dart';

class NewPrivateEventSearchGroupchatTab extends StatefulWidget {
  const NewPrivateEventSearchGroupchatTab({super.key});

  @override
  State<NewPrivateEventSearchGroupchatTab> createState() =>
      _NewPrivateEventSearchGroupchatTabState();
}

class _NewPrivateEventSearchGroupchatTabState
    extends State<NewPrivateEventSearchGroupchatTab> {
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getChatsViaApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, chatState) {
          return BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
            buildWhen: (previous, current) =>
                previous.selectedGroupchat?.id != current.selectedGroupchat?.id,
            builder: (context, state) {
              if (state.selectedGroupchat?.id != null) {
                BlocProvider.of<AddPrivateEventCubit>(context)
                    .getCalendarTimeUsers();
              }

              return ChatGridList(
                groupchats:
                    chatState.chatStates.map((e) => e.currentChat).toList(),
                highlightIds: state.selectedGroupchat != null
                    ? [state.selectedGroupchat!.id]
                    : null,
                onPress: (groupchat) {
                  BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    selectedGroupchat: groupchat,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
