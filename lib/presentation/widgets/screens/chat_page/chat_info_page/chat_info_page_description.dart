import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';

class ChatInfoPageDescription extends StatelessWidget {
  const ChatInfoPageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      buildWhen: (previous, current) {
        if (previous.currentChat.description !=
            current.currentChat.description) {
          return true;
        }
        if (previous.loadingChat != current.loadingChat) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state.currentChat.description == null && state.loadingChat) {
          return const SkeletonLine();
        }

        final String? description = state.currentChat.description;
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: EditInputTextField(
              text: description != null && description.isNotEmpty
                  ? description
                  : "Keine Beschreibung",
              textStyle: Theme.of(context).textTheme.titleMedium,
              editable: state.getCurrentGroupchatUser()?.admin == true,
              onSaved: (text) {
                BlocProvider.of<CurrentChatCubit>(context)
                    .updateCurrentGroupchatViaApi(
                  updateGroupchatDto: UpdateGroupchatDto(
                    description: text,
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
