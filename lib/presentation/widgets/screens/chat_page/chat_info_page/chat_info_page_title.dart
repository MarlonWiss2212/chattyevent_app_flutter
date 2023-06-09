import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';

class ChatInfoPageTitle extends StatelessWidget {
  const ChatInfoPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        return Hero(
          tag: "${state.currentChat.id} title",
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: EditInputTextField(
              text: state.currentChat.title ?? "",
              textStyle: Theme.of(context).textTheme.titleLarge?.apply(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              editable: state.getCurrentGroupchatUser()?.admin == true,
              onSaved: (text) {
                BlocProvider.of<CurrentChatCubit>(context)
                    .updateCurrentGroupchatViaApi(
                  updateGroupchatDto: UpdateGroupchatDto(
                    title: text,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
