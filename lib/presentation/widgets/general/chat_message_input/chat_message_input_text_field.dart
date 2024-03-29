import 'dart:ui';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/add_chat_message_detail_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageInputTextField extends StatefulWidget {
  const ChatMessageInputTextField({super.key});

  @override
  State<ChatMessageInputTextField> createState() =>
      _ChatMessageInputTextFieldState();
}

class _ChatMessageInputTextFieldState extends State<ChatMessageInputTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMessageCubit, AddMessageState>(
      listener: (context, state) =>
          state.status == AddMessageStateStatus.success
              ? textEditingController.clear()
              : null,
      builder: (context, state) {
        final borderRadius = state.messageToReactToWithUser != null ||
                state.status == AddMessageStateStatus.loading
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.circular(12);

        return Column(
          children: [
            if (state.status == AddMessageStateStatus.loading) ...{
              const LinearProgressIndicator(),
            },
            ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(.6),
                  ),
                  constraints: const BoxConstraints(minHeight: 50),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: textEditingController,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 6,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration.collapsed(
                            hintText:
                                "general.chatMessageInput.textField.hintText"
                                    .tr(),
                          ),
                          onChanged: (p0) =>
                              BlocProvider.of<AddMessageCubit>(context)
                                  .emitState(
                            message: p0,
                          ),
                        ),
                      ),
                      InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () async {
                          await showAnimatedDialog(
                            context: context,
                            curve: Curves.fastOutSlowIn,
                            animationType:
                                DialogTransitionType.slideFromBottomFade,
                            builder: (c) =>
                                AddChatMessageDetailDialog(c: context),
                          );
                        },
                        child: Ink(
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(.6),
                          ),
                          child: const Icon(Icons.file_copy, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
