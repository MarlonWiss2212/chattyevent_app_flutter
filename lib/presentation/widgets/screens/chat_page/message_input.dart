import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/add_message_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/presentation/widgets/bottom_sheet/image_picker_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class MessageInput extends StatelessWidget {
  final String groupchatTo;
  const MessageInput({super.key, required this.groupchatTo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AddMessageCubit(
        AddMessageState(groupchatTo: groupchatTo),
        currentChatCubit: BlocProvider.of<CurrentChatCubit>(context),
        messageUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
      ),
      child: Builder(
        builder: (context) {
          return BlocConsumer<AddMessageCubit, AddMessageState>(
            listener: (context, state) async {
              if (state.status == AddMessageStateStatus.error &&
                  state.error != null) {
                return await showPlatformDialog(
                  context: context,
                  builder: (context) {
                    return PlatformAlertDialog(
                      title: Text(state.error!.title),
                      content: Text(state.error!.message),
                      actions: const [OKButton()],
                    );
                  },
                );
              }
            },
            buildWhen: (previous, current) =>
                current.status == AddMessageStateStatus.success,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AddMessageCubit, AddMessageState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      if (state.status == AddMessageStateStatus.loading) {
                        return const LinearProgressIndicator();
                      }
                      return Container();
                    },
                  ),
                  BlocBuilder<AddMessageCubit, AddMessageState>(
                    buildWhen: (previous, current) =>
                        previous.file != current.file,
                    builder: (context, state) {
                      if (state.file != null) {
                        return SizedBox(
                          height: 100,
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<AddMessageCubit>(context)
                                  .emitState(
                                removeFile: true,
                              );
                            },
                            child: Image.file(
                              BlocProvider.of<AddMessageCubit>(context)
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
                                    BlocProvider.of<AddMessageCubit>(context)
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
                                          BlocProvider.of<AddMessageCubit>(
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
                          BlocProvider.of<AddMessageCubit>(context)
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
        },
      ),
    );
  }
}
