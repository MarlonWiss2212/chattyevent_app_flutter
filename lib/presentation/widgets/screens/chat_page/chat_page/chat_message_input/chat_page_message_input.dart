import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_message_input/chat_page_message_input_react_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/add_groupchat_message_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/bottom_sheet/image_picker_list.dart';
import 'package:ionicons/ionicons.dart';

class ChatPageMessageInput extends StatelessWidget {
  const ChatPageMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupchatMessageCubit, AddGroupchatMessageState>(
      buildWhen: (previous, current) =>
          current.status == AddGroupchatMessageStateStatus.success,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  children: [
                    BlocBuilder<AddGroupchatMessageCubit,
                        AddGroupchatMessageState>(
                      buildWhen: (previous, current) =>
                          previous.file != current.file,
                      builder: (context, state) {
                        if (state.file != null) {
                          return Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeIn,
                                height: 100,
                                child: Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<AddGroupchatMessageCubit>(
                                              context)
                                          .emitState(
                                        removeFile: true,
                                      );
                                    },
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              BlocProvider.of<
                                                          AddGroupchatMessageCubit>(
                                                      context)
                                                  .state
                                                  .file!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xCC000000),
                                                Color(0x00000000),
                                                Color(0x00000000),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () => BlocProvider.of<
                                                          AddGroupchatMessageCubit>(
                                                      context)
                                                  .emitState(removeFile: true),
                                              child: const Icon(Ionicons.close),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    const ChatPageMessageInputReactMessageContainer(),
                    BlocBuilder<AddGroupchatMessageCubit,
                        AddGroupchatMessageState>(
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: state.messageToReactTo != null
                                ? const BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  )
                                : BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: PlatformTextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 6,
                              material: (context, platform) =>
                                  MaterialTextFieldData(
                                decoration: const InputDecoration.collapsed(
                                  hintText: "Nachricht",
                                ),
                              ),
                              onChanged: (p0) {
                                BlocProvider.of<AddGroupchatMessageCubit>(
                                        context)
                                    .emitState(message: p0);
                              },
                              hintText: 'Nachricht',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (modalContext) {
                      return ImagePickerList(
                        imageChanged: (newImage) {
                          BlocProvider.of<AddGroupchatMessageCubit>(context)
                              .emitState(file: newImage);
                          Navigator.of(modalContext).pop();
                        },
                      );
                    },
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Ionicons.camera,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () => BlocProvider.of<AddGroupchatMessageCubit>(context)
                    .createMessage(),
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Ionicons.send,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
