import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/message_container.dart';

class MessageList extends StatefulWidget {
  final String groupchatTo;
  final List<MessageEntity> messages;

  const MessageList({
    super.key,
    required this.groupchatTo,
    required this.messages,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoaded) {
          Map<String, dynamic> tokenPayload = Jwt.parseJwt(state.token);

          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 8),
                itemBuilder: (context, index) {
                  UserEntity? foundUser;
                  if (state is UserStateLoaded) {
                    for (final user in state.users) {
                      if (user.id == widget.messages[index].createdBy) {
                        foundUser = user;
                      }
                    }
                  }

                  return MessageContainer(
                    title: foundUser == null
                        ? widget.messages[index].createdBy ??
                            "Keine Id gefunden"
                        : foundUser.username ??
                            widget.messages[index].createdBy ??
                            "Keine Id gefunden",
                    date: widget.messages[index].createdAt != null
                        ? "${widget.messages[index].createdAt!.year.toString()}.${widget.messages[index].createdAt!.month.toString()}.${widget.messages[index].createdAt!.day.toString()}, ${widget.messages[index].createdAt!.hour.toString()}:${widget.messages[index].createdAt!.minute.toString()}"
                        : "Fehler",
                    content: widget.messages[index].message ?? "Kein Inhalt",
                    alignStart:
                        widget.messages[index].createdBy != tokenPayload["sub"],
                  );
                },
                itemCount: widget.messages.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 4);
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
