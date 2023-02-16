import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_list/chat_grid_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_list/chat_grid_list_item.dart';

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
  Widget build(BuildContext context) {
    BlocProvider.of<ChatCubit>(context).getChatsViaApi();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const SizedBox(height: 8),
          BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
            buildWhen: (previous, current) =>
                previous.selectedGroupchat?.id != current.selectedGroupchat?.id,
            builder: (context, state) {
              if (state.selectedGroupchat != null) {
                return SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      Text(
                        "Ausgewählter Chat: ",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ChatGridListItem(
                          chat: state.selectedGroupchat!,
                          onPress: () {
                            BlocProvider.of<AddPrivateEventCubit>(context)
                                .emitState(
                              resetSelectedGroupchat: true,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Text("Bitte wähle einen Gruppenchat aus");
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return ChatGridList(
                  groupchats: state.chats,
                  onPress: (groupchat) {
                    BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                      selectedGroupchat: groupchat,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
