import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/groupchat_list/groupchat_grid_list.dart';

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
          return BlocBuilder<AddEventCubit, AddEventState>(
            buildWhen: (previous, current) =>
                previous.selectedGroupchat?.id != current.selectedGroupchat?.id,
            builder: (context, state) {
              if (state.selectedGroupchat?.id != null) {
                BlocProvider.of<AddEventCubit>(context).getCalendarTimeUsers();
              }

              return Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: GroupchatGridList(
                      key: const Key("NewEventSearchGroupchatPage"),
                      // TODO: check for permissions to filter out || load groupchats from api
                      groupchats: chatState.chats
                          .where((element) => element.groupchat != null)
                          .map((e) => e.groupchat!)
                          .toList(),
                      highlightIds: state.selectedGroupchat != null
                          ? [state.selectedGroupchat!.id]
                          : null,
                      onPress: (groupchat) {
                        BlocProvider.of<AddEventCubit>(context).emitState(
                          selectedGroupchat: groupchat,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
