import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/message/add_message_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_left_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_react_message_container.dart';

class ChatPageMessageContainer extends StatelessWidget {
  const ChatPageMessageContainer({
    super.key,
    required this.message,
    required this.currentUserId,
    required this.usersWithGroupchatUserData,
    required this.usersWithLeftGroupchatUserData,
    this.showMessageReactTo = true,
    this.showImage = true,
  });

  final bool showMessageReactTo;
  final bool showImage;

  final String currentUserId;
  final List<UserWithGroupchatUserData> usersWithGroupchatUserData;
  final List<UserWithLeftGroupchatUserData> usersWithLeftGroupchatUserData;
  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    final actionPane = ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Colors.white,
          onPressed: (context) {
            BlocProvider.of<AddMessageCubit>(context).emitState(
              messageToReactTo: message.id,
            );
          },
          icon: Icons.arrow_circle_left_sharp,
        ),
      ],
    );

    UserEntity? user;
    final foundUser = usersWithGroupchatUserData.firstWhere(
      (element) => element.id == message.createdBy,
      orElse: () => UserWithGroupchatUserData(id: ""),
    );
    if (foundUser.id == "") {
      final foundLeftUser = usersWithLeftGroupchatUserData.firstWhere(
        (element) => element.id == message.createdBy,
        orElse: () => UserWithLeftGroupchatUserData(id: ""),
      );

      if (foundLeftUser.id != "") {
        user = foundLeftUser;
      }
    } else {
      user = foundUser;
    }
    return Row(
      mainAxisAlignment: user?.id == currentUserId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Slidable(
          enabled: showMessageReactTo,
          startActionPane: user?.id == currentUserId ? null : actionPane,
          endActionPane: user?.id == currentUserId ? actionPane : null,
          child: Container(
            constraints: showMessageReactTo
                ? BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.1,
                  )
                : null,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: showMessageReactTo
                  ? user?.id == currentUserId
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                      : const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                  : null,
              color: user?.id == currentUserId
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user != null && user.username != null
                          ? user.username!
                          : message.createdBy ?? "",
                    ),
                    const SizedBox(width: 8),
                    Text(message.createdAt != null
                        ? DateFormat.jm().format(message.createdAt!)
                        : "Fehler"),
                  ],
                ),
                if (message.fileLink != null && showImage) ...{
                  Image.network(message.fileLink!, fit: BoxFit.contain)
                },
                if (message.messageToReactTo != null && showMessageReactTo) ...{
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    child: ChatPageReactMessageContainer(
                      messageToReactTo: message.messageToReactTo!,
                    ),
                  ),
                },
                if (message.message != null) ...{
                  Text(message.message!, overflow: TextOverflow.clip),
                },
              ],
            ),
          ),
        ),
      ],
    );
  }
}
