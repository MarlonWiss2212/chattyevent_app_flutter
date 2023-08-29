import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
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
      List<ChatEntity> chats = state.chats;

      int index = 0;
      for (final chat in chats) {
        if (chat.event != null &&
            chat.event?.id == event.addedMessage?.eventTo) {
          final ChatEntity updatedChat = ChatEntity.merge(
            newEntity: ChatEntity(
              event: EventEntity.merge(
                newEntity: EventEntity(
                  id: chat.event!.id,
                  eventDate: chat.event!.eventDate,
                  latestMessage: event.addedMessage,
                ),
                oldEntity: chat.event!,
              ),
            ),
            oldEntity: chat,
          );
          chats[index] = updatedChat;
        } else if (chat.groupchat != null &&
            chat.groupchat?.id == event.addedMessage?.groupchatTo) {
          final ChatEntity updatedChat = ChatEntity.merge(
            newEntity: ChatEntity(
              groupchat: GroupchatEntity.merge(
                newEntity: GroupchatEntity(
                  id: chat.groupchat!.id,
                  latestMessage: event.addedMessage,
                ),
                oldEntity: chat.groupchat!,
              ),
            ),
            oldEntity: chat,
          );
          chats[index] = updatedChat;
        } else if (chat.user != null &&
            ((event.addedMessage?.createdBy == chat.user?.id &&
                    event.addedMessage?.userTo ==
                        authCubit.state.currentUser.id) ||
                (event.addedMessage?.createdBy ==
                        authCubit.state.currentUser.id &&
                    event.addedMessage?.userTo == chat.user?.id))) {
          final ChatEntity updatedChat = ChatEntity.merge(
            newEntity: ChatEntity(
              user: UserEntity.merge(
                newEntity: UserEntity(
                  id: chat.user!.id,
                  authId: chat.user!.authId,
                  latestMessage: event.addedMessage,
                ),
                oldEntity: chat.user!,
              ),
            ),
            oldEntity: chat,
          );
          chats[index] = updatedChat;
        }
        index++;
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
