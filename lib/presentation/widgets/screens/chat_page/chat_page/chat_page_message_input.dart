import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/current_groupchat/add_groupchat_message_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/bottom_sheet/image_picker_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_react_message_container.dart';

class ChatPageMessageInput extends StatelessWidget {
  final String groupchatTo;
  const ChatPageMessageInput({super.key, required this.groupchatTo});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupchatMessageCubit, AddGroupchatMessageState>(
      buildWhen: (previous, current) =>
          current.status == AddGroupchatMessageStateStatus.success,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AddGroupchatMessageCubit, AddGroupchatMessageState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == AddGroupchatMessageStateStatus.loading) {
                  return const LinearProgressIndicator();
                }
                return Container();
              },
            ),
            BlocBuilder<AddGroupchatMessageCubit, AddGroupchatMessageState>(
              buildWhen: (previous, current) => previous.file != current.file,
              builder: (context, state) {
                if (state.file != null) {
                  return SizedBox(
                    height: 100,
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<AddGroupchatMessageCubit>(context)
                            .emitState(
                          removeFile: true,
                        );
                      },
                      child: Image.file(
                        BlocProvider.of<AddGroupchatMessageCubit>(context)
                            .state
                            .file!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            BlocBuilder<AddGroupchatMessageCubit, AddGroupchatMessageState>(
              builder: (context, state) {
                if (state.messageToReactTo != null) {
                  return InkWell(
                    onTap: () =>
                        BlocProvider.of<AddGroupchatMessageCubit>(context)
                            .emitState(
                      removeMessageToReactTo: true,
                    ),
                    child: Scrollable(
                      viewportBuilder: (context, position) =>
                          ChatPageReactMessageContainer(
                        messageToReactTo: state.messageToReactTo!,
                        isInputMessage: true,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            Row(
              children: [
                // input area
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: PlatformTextField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 6,
                            controller: TextEditingController(text: ""),
                            material: (context, platform) =>
                                MaterialTextFieldData(
                              decoration: const InputDecoration.collapsed(
                                hintText: "Nachricht",
                              ),
                            ),
                            onChanged: (p0) {
                              BlocProvider.of<AddGroupchatMessageCubit>(context)
                                  .emitState(message: p0);
                            },
                            hintText: 'Nachricht',
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                              context: context,
                              builder: (modalContext) {
                                return ImagePickerList(
                                  imageChanged: (newImage) {
                                    BlocProvider.of<AddGroupchatMessageCubit>(
                                            context)
                                        .emitState(file: newImage);
                                    Navigator.of(modalContext).pop();
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.file_copy),
                        ),
                      ],
                    ),
                  ),
                ),
                // send button
                IconButton(
                  onPressed: () {
                    BlocProvider.of<AddGroupchatMessageCubit>(context)
                        .createMessage();
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
