import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/message/message_stream_type_enum.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCases chatUseCases;
  final NotificationCubit notificationCubit;
  final AuthCubit authCubit;
  final MessageStreamCubit messageStreamCubit;
  ChatCubit({
    required this.chatUseCases,
    required this.notificationCubit,
    required this.authCubit,
    required this.messageStreamCubit,
  }) : super(const ChatState(chats: [])) {
    messageStreamCubit.stream.listen((event) {
      if (event.message == null) {
        return;
      }

      List<ChatEntity> chats = state.chats;

      for (int index = 0; index < chats.length; index++) {
        final chat = chats[index];

        bool isUpdateMessageValid() {
          if (chat.event != null && chat.event?.id == event.message?.eventTo) {
            return event.message?.createdAt != null &&
                (chat.event!.latestMessage?.createdAt == null ||
                    event.message!.createdAt
                        .isAfter(chat.event!.latestMessage!.createdAt));
          } else if (chat.groupchat != null &&
              chat.groupchat?.id == event.message?.groupchatTo) {
            return event.message?.createdAt != null &&
                (chat.groupchat!.latestMessage?.createdAt == null ||
                    event.message!.createdAt
                        .isAfter(chat.groupchat!.latestMessage!.createdAt));
          } else if (chat.user != null &&
              ((event.message?.createdBy == chat.user?.id &&
                      event.message?.userTo ==
                          authCubit.state.currentUser.id) ||
                  (event.message?.createdBy == authCubit.state.currentUser.id &&
                      event.message?.userTo == chat.user?.id))) {
            return event.message?.createdAt != null &&
                (chat.user!.latestMessage?.createdAt == null ||
                    event.message!.createdAt
                        .isAfter(chat.user!.latestMessage!.createdAt));
          }

          return false;
        }

        if (event.streamType == MessageStreamTypeEnum.updated) {
          // Handle updated messages
          if (isUpdateMessageValid()) {
            if (chat.event != null &&
                chat.event?.id == event.message?.eventTo) {
              final updatedChat = ChatEntity.merge(
                newEntity: ChatEntity(
                  event: EventEntity.merge(
                    newEntity: EventEntity(
                      id: chat.event!.id,
                      eventDate: chat.event!.eventDate,
                      latestMessage: event.message,
                    ),
                    oldEntity: chat.event!,
                  ),
                ),
                oldEntity: chat,
              );
              chats[index] = updatedChat;
            } else if (chat.groupchat != null &&
                chat.groupchat?.id == event.message?.groupchatTo) {
              final updatedChat = ChatEntity.merge(
                newEntity: ChatEntity(
                  groupchat: GroupchatEntity.merge(
                    newEntity: GroupchatEntity(
                      id: chat.groupchat!.id,
                      latestMessage: event.message,
                    ),
                    oldEntity: chat.groupchat!,
                  ),
                ),
                oldEntity: chat,
              );
              chats[index] = updatedChat;
            } else if (chat.user != null &&
                ((event.message?.createdBy == chat.user?.id &&
                        event.message?.userTo ==
                            authCubit.state.currentUser.id) ||
                    (event.message?.createdBy ==
                            authCubit.state.currentUser.id &&
                        event.message?.userTo == chat.user?.id))) {
              final updatedChat = ChatEntity.merge(
                newEntity: ChatEntity(
                  user: UserEntity.merge(
                    newEntity: UserEntity(
                      id: chat.user!.id,
                      authId: chat.user!.authId,
                      latestMessage: event.message,
                    ),
                    oldEntity: chat.user!,
                  ),
                ),
                oldEntity: chat,
              );
              chats[index] = updatedChat;
            }
          }
        } else if (event.streamType == MessageStreamTypeEnum.added) {
          // Handle added messages
          if (chat.event != null && chat.event?.id == event.message?.eventTo) {
            final addedChat = ChatEntity.merge(
              newEntity: ChatEntity(
                event: EventEntity.merge(
                  newEntity: EventEntity(
                    id: chat.event!.id,
                    eventDate: chat.event!.eventDate,
                    latestMessage: event.message,
                  ),
                  oldEntity: chat.event!,
                ),
              ),
              oldEntity: chat,
            );
            chats[index] = addedChat;
          } else if (chat.groupchat != null &&
              chat.groupchat?.id == event.message?.groupchatTo) {
            final addedChat = ChatEntity.merge(
              newEntity: ChatEntity(
                groupchat: GroupchatEntity.merge(
                  newEntity: GroupchatEntity(
                    id: chat.groupchat!.id,
                    latestMessage: event.message,
                  ),
                  oldEntity: chat.groupchat!,
                ),
              ),
              oldEntity: chat,
            );
            chats[index] = addedChat;
          } else if (chat.user != null &&
              ((event.message?.createdBy == chat.user?.id &&
                      event.message?.userTo ==
                          authCubit.state.currentUser.id) ||
                  (event.message?.createdBy == authCubit.state.currentUser.id &&
                      event.message?.userTo == chat.user?.id))) {
            final addedChat = ChatEntity.merge(
              newEntity: ChatEntity(
                user: UserEntity.merge(
                  newEntity: UserEntity(
                    id: chat.user!.id,
                    authId: chat.user!.authId,
                    latestMessage: event.message,
                  ),
                  oldEntity: chat.user!,
                ),
              ),
              oldEntity: chat,
            );
            chats[index] = addedChat;
          }
        }
      }

      emit(ChatState(chats: chats));
    });
  }

  @override
  void emit(ChatState state) {
    List<ChatEntity> chats = state.chats;
    if (chats.isNotEmpty) {
      chats.sort((a, b) {
        final latestMessageA = a.groupchat?.latestMessage ??
            a.event?.latestMessage ??
            a.user?.latestMessage;

        final latestMessageB = b.groupchat?.latestMessage ??
            b.event?.latestMessage ??
            b.user?.latestMessage;

        if (latestMessageA == null && latestMessageB == null) {
          return 0;
        } else if (latestMessageB == null) {
          return -1;
        } else if (latestMessageA == null) {
          return 1;
        } else if (latestMessageA.createdAt.isAfter(latestMessageB.createdAt)) {
          return -1;
        } else {
          return 1;
        }
      });
    }
    super.emit(ChatState(chats: chats, status: state.status));
  }

  ChatEntity replaceOrAdd({
    required ChatEntity chat,
  }) {
    int foundIndex = state.chats.indexWhere((element) {
      if (element.groupchat != null && chat.groupchat != null) {
        return element.groupchat!.id == chat.groupchat!.id;
      } else if (element.event != null && chat.event != null) {
        return element.event!.id == chat.event!.id;
      } else if (element.user != null && chat.user != null) {
        return element.user!.id == chat.user!.id;
      }
      return false;
    });

    if (foundIndex != -1) {
      List<ChatEntity> newChats = state.chats;
      newChats[foundIndex] = chat;
      emit(ChatState(chats: newChats));
      return newChats[foundIndex];
    } else {
      emit(ChatState(chats: [chat, ...state.chats]));
    }
    return chat;
  }

  List<ChatEntity> replaceOrAddMultiple({
    required List<ChatEntity> chats,
  }) {
    List<ChatEntity> mergedChats = [];
    for (final chat in chats) {
      final mergedChat = replaceOrAdd(chat: chat);
      mergedChats.add(mergedChat);
    }
    return mergedChats;
  }

  void delete({
    String? groupchatId,
    String? eventId,
    String? userId,
  }) {
    List<ChatEntity> newChats = state.chats;
    newChats.removeWhere(
      (element) => groupchatId != null
          ? element.groupchat?.id == groupchatId
          : eventId != null
              ? element.event?.id == eventId
              : element.user?.id == userId,
    );
    emit(ChatState(chats: newChats));
  }

  Future getChatsViaApi() async {
    emit(ChatState(chats: state.chats, status: ChatStateStatus.loading));

    final Either<NotificationAlert, List<ChatEntity>> chatsOrFailure =
        await chatUseCases.getChatsViaApi();

    chatsOrFailure.fold(
      (alert) {
        ChatState(chats: state.chats, status: ChatStateStatus.initial);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (chats) {
        emit(
          ChatState(status: ChatStateStatus.success, chats: chats),
        );
      },
    );
  }
}
