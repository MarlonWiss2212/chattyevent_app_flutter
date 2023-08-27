import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class ChatMessageContainerBottomContainer extends StatelessWidget {
  final bool isCurrentUser;
  final List<UserEntity> users;
  final MessageEntity message;
  const ChatMessageContainerBottomContainer({
    super.key,
    required this.isCurrentUser,
    required this.message,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(
          DateFormat.jm().format(message.createdAt),
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.apply(color: isDarkMode ? Colors.white54 : Colors.black54),
        ),
        const SizedBox(width: 8),
        if (isCurrentUser &&
            message.readBy.isNotEmpty &&
            message.readBy.length == users.length) ...[
          Stack(
            children: [
              Icon(
                Ionicons.checkmark,
                color: isDarkMode ? Colors.white54 : Colors.black54,
                size: Theme.of(context).textTheme.bodySmall?.fontSize,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(
                  Ionicons.checkmark,
                  color: isDarkMode ? Colors.white54 : Colors.black54,
                  size: Theme.of(context).textTheme.bodySmall?.fontSize,
                ),
              ),
            ],
          ),
        ] else if (isCurrentUser) ...{
          Icon(
            Ionicons.checkmark,
            color: isDarkMode ? Colors.white54 : Colors.black54,
            size: Theme.of(context).textTheme.bodySmall?.fontSize,
          ),
        }
      ],
    );
  }
}
