import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/add_message_cubit.dart';
import 'package:social_media_app_flutter/core/dto/create_message_dto.dart';
import 'package:social_media_app_flutter/core/graphql.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/message_repository_impl.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class MessageInput extends StatefulWidget {
  final String groupchatTo;
  const MessageInput({super.key, required this.groupchatTo});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final messageInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final client = getGraphQlClient(
      token: BlocProvider.of<AuthCubit>(context).state is AuthLoaded
          ? (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token
          : null,
    );

    return BlocProvider.value(
      value: AddMessageCubit(
        currentChatCubit: BlocProvider.of<CurrentChatCubit>(context),
        messageUseCases: MessageUseCases(
          messageRepository: MessageRepositoryImpl(
            graphQlDatasource: GraphQlDatasourceImpl(
              client: client,
            ),
          ),
        ),
      ),
      child: Builder(builder: (context) {
        return BlocListener<AddMessageCubit, AddMessageState>(
          listener: (context, state) async {
            if (state.status == AddMessageStateStatus.success) {
              messageInputController.clear();
            } else if (state.status == AddMessageStateStatus.error &&
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
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                // input area
                Expanded(
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    duration: const Duration(seconds: 5),
                    child: PlatformTextField(
                      material: (context, platform) => MaterialTextFieldData(
                        decoration: const InputDecoration.collapsed(
                          hintText: "Nachricht",
                        ),
                      ),
                      controller: messageInputController,
                      hintText: 'Nachricht',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // send button
                PlatformTextButton(
                  // ios style missing
                  material: ((context, platform) => MaterialTextButtonData(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith(
                            (states) => const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) =>
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                      )),
                  onPressed: () {
                    BlocProvider.of<AddMessageCubit>(context).createMessage(
                      createMessageDto: CreateMessageDto(
                        groupchatTo: widget.groupchatTo,
                        message: messageInputController.text,
                      ),
                    );
                  },
                  child: const Center(
                    child: Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
