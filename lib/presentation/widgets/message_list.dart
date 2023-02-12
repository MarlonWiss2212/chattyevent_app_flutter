import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_left_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/message_container.dart';

class MessageList extends StatelessWidget {
  final String groupchatTo;
  final List<MessageEntity> messages;

  const MessageList({
    super.key,
    required this.groupchatTo,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = Jwt.parseJwt(
        (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token)["sub"];

    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        return GroupedListView<MessageEntity, String>(
          padding: const EdgeInsets.only(top: 8),
          itemBuilder: (context, messageEntity) {
            UserEntity? user;
            final foundUser = state.usersWithGroupchatUserData.firstWhere(
              (element) => element.id == messageEntity.createdBy,
              orElse: () => UserWithGroupchatUserData(id: ""),
            );
            if (foundUser.id == "") {
              final foundLeftUser =
                  state.usersWithLeftGroupchatUserData.firstWhere(
                (element) => element.id == messageEntity.createdBy,
                orElse: () => UserWithLeftGroupchatUserData(id: ""),
              );

              if (foundLeftUser.id != "") {
                user = foundLeftUser;
              }
            } else {
              user = foundUser;
            }

            return MessageContainer(
              title: user != null && user.username != null
                  ? user.username!
                  : messageEntity.createdBy ?? "",
              date: messageEntity.createdAt != null
                  ? DateFormat.jm().format(messageEntity.createdAt!)
                  : "Fehler",
              content: messageEntity.message ?? "Kein Inhalt",
              alignStart: messageEntity.createdBy != currentUserId,
            );
          },
          elements: messages,
          useStickyGroupSeparators: true,
          reverse: true,
          order: GroupedListOrder.DESC,
          floatingHeader: true,
          groupBy: (messageEntity) {
            if (messageEntity.createdAt == null) {
              return "Fehler";
            }
            return DateTime(
              messageEntity.createdAt!.year,
              messageEntity.createdAt!.month,
              messageEntity.createdAt!.day,
            ).toString();
          },
          groupHeaderBuilder: (messageEntity) {
            return SizedBox(
              height: 40,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      messageEntity.createdAt == null
                          ? "Kein Datum gefunden"
                          : DateFormat.yMMMd().format(messageEntity.createdAt!),
                    ),
                  ),
                ),
              ),
            );
          },
          groupSeparatorBuilder: (value) {
            return const SizedBox(
              height: 8,
            );
          },
        );
      },
    );
  }
}
