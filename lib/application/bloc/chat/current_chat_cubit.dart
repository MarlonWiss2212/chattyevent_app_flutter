import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/added_message_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_messages_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_private_events_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/response/get-all-groupchat-users-and-left-users.response.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'current_chat_state.dart';

class CurrentChatCubit extends Cubit<CurrentChatState> {
  final AuthCubit authCubit;
  final ChatCubit chatCubit;
  final NotificationCubit notificationCubit;

  final ChatUseCases chatUseCases;
  final MessageUseCases messageUseCases;
  final PrivateEventUseCases privateEventUseCases;

  StreamSubscription<Either<NotificationAlert, MessageEntity>>? _subscription;

  CurrentChatCubit(
    super.initialState, {
    required this.authCubit,
    required this.messageUseCases,
    required this.privateEventUseCases,
    required this.chatCubit,
    required this.notificationCubit,
    required this.chatUseCases,
  });

  void listenToMessages() {
    final subscription = messageUseCases.getMessagesRealtimeViaApi(
      addedMessageFilter: AddedMessageFilter(
        groupchatTo: state.currentChat.id,
      ),
    );

    _subscription = subscription.listen(
      (event) {
        event.fold(
          (error) => notificationCubit.newAlert(
            notificationAlert: NotificationAlert(
              title: "Nachrichten error",
              message:
                  "Fehler beim herstellen einer Verbindung um live nachrichten zu erhalten",
            ),
          ),
          (message) => addMessage(
            message: message,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future getGroupchatUsersViaApi() async {
    /// optimize this
    final Either<NotificationAlert, GetAllGroupchatUsersAndLeftUsers>
        groupchatUsersAndLeftUsers =
        await chatUseCases.getGroupchatUsersAndLeftUsers(
      groupchatId: state.currentChat.id,
    );
    groupchatUsersAndLeftUsers.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (usersAndLeftUsers) {
        emit(
          CurrentChatState.merge(
            oldState: state,
            users: usersAndLeftUsers.groupchatUsers,
            leftUsers: usersAndLeftUsers.groupchatLeftUsers,
            currentUserIndex: usersAndLeftUsers.groupchatUsers.indexWhere(
              (element) => element.id == authCubit.state.currentUser.id,
            ),
          ),
        );
      },
    );
  }

  Future getFutureConnectedPrivateEventsFromApi({
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    emit(CurrentChatState.merge(oldState: state, loadingPrivateEvents: true));

    final privateEventsOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi(
      limitOffsetFilter: limitOffsetFilter,
      getPrivateEventsFilter: GetPrivateEventsFilter(
        onlyFutureEvents: true,
        sortNewestDateFirst: false,
        groupchatTo: state.currentChat.id,
      ),
    );

    privateEventsOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          CurrentChatState.merge(oldState: state, loadingPrivateEvents: false),
        );
      },
      (privateEvents) {
        emit(CurrentChatState.merge(
          oldState: state,
          loadingPrivateEvents: false,
        ));
        for (final privateEvent in privateEvents) {
          replaceOrAddFutureConnectedPrivateEvent(privateEvent: privateEvent);
        }
      },
    );
  }

  PrivateEventEntity replaceOrAddFutureConnectedPrivateEvent({
    required PrivateEventEntity privateEvent,
  }) {
    int foundIndex = state.futureConnectedPrivateEvents.indexWhere(
      (element) => element.id == privateEvent.id,
    );

    if (foundIndex != -1) {
      List<PrivateEventEntity> newPrivateEvents =
          state.futureConnectedPrivateEvents;
      newPrivateEvents[foundIndex] = privateEvent;

      emit(CurrentChatState.merge(
        oldState: state,
        futureConnectedPrivateEvents: newPrivateEvents,
      ));
      chatCubit.replaceOrAdd(chatState: state);
      return newPrivateEvents[foundIndex];
    } else {
      List<PrivateEventEntity> newPrivateEvents =
          List.from(state.futureConnectedPrivateEvents)..add(privateEvent);
      newPrivateEvents.sort(
        (a, b) => a.eventDate!.compareTo(b.eventDate!),
      );
      emit(CurrentChatState.merge(
        oldState: state,
        futureConnectedPrivateEvents: newPrivateEvents,
      ));
      chatCubit.replaceOrAdd(chatState: state);
    }
    return privateEvent;
  }

  Future getCurrentChatViaApi() async {
    emit(CurrentChatState.merge(
      oldState: state,
      loadingChat: true,
    ));

    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: GetOneGroupchatFilter(id: state.currentChat.id),
    );

    groupchatOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          CurrentChatState.merge(oldState: state, loadingChat: false),
        );
      },
      (groupchat) async {
        emit(CurrentChatState.merge(
          currentChat: groupchat,
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chatState: state);
      },
    );
  }

  Future updateCurrentGroupchatViaApi({
    required UpdateGroupchatDto updateGroupchatDto,
  }) async {
    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.updateGroupchatViaApi(
      getOneGroupchatFilter: GetOneGroupchatFilter(id: state.currentChat.id),
      updateGroupchatDto: updateGroupchatDto,
    );

    groupchatOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (groupchat) {
        emit(CurrentChatState.merge(currentChat: groupchat, oldState: state));
        chatCubit.replaceOrAdd(chatState: state);
      },
    );
  }

  Future addUserToChat({required String userId}) async {
    emit(CurrentChatState.merge(
      oldState: state,
      loadingChat: true,
    ));
    final Either<NotificationAlert, GroupchatUserEntity> groupchatOrFailure =
        await chatUseCases.addUserToGroupchatViaApi(
      createGroupchatUserDto: CreateGroupchatUserDto(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(CurrentChatState.merge(oldState: state, loadingChat: false));
      },
      (groupchatUser) {
        emit(CurrentChatState.merge(
          leftUsers: List.from(state.leftUsers)
            ..removeWhere((element) => element.id == groupchatUser.id),
          users: List.from(state.users)..add(groupchatUser),
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chatState: state);
      },
    );
  }

  Future updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required String userId,
  }) async {
    final updatedUserOrFailure = await chatUseCases.updateGroupchatUserViaApi(
      updateGroupchatUserDto: updateGroupchatUserDto,
      getOneGroupchatUserFilter: GetOneGroupchatUserFilter(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    updatedUserOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (groupchatUser) {
        List<GroupchatUserEntity> newGroupchatUsers = state.users;

        int foundIndex = newGroupchatUsers.indexWhere(
          (element) => element.id == groupchatUser.id,
        );
        if (foundIndex != -1) {
          newGroupchatUsers[foundIndex] = groupchatUser;
        } else {
          newGroupchatUsers.add(groupchatUser);
        }

        emit(CurrentChatState.merge(
          users: newGroupchatUsers,
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chatState: state);
      },
    );
  }

  Future deleteUserFromChat({required String userId}) async {
    emit(CurrentChatState.merge(
      oldState: state,
      loadingChat: true,
    ));
    final Either<NotificationAlert, GroupchatLeftUserEntity?>
        groupchatOrFailure = await chatUseCases.deleteUserFromGroupchatViaApi(
      getOneGroupchatUserFilter: GetOneGroupchatUserFilter(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          CurrentChatState.merge(oldState: state, loadingChat: false),
        );
      },
      (groupchatLeftUser) {
        if (groupchatLeftUser == null ||
            userId == authCubit.state.currentUser.id) {
          emit(CurrentChatState.merge(
            currentUserLeftChat: true,
            loadingChat: false,
            oldState: state,
          ));
          chatCubit.delete(groupchatId: state.currentChat.id);
        } else {
          emit(CurrentChatState.merge(
            users: List.from(state.users)
              ..removeWhere((element) => element.id == groupchatLeftUser.id),
            leftUsers: List.from(state.leftUsers)..add(groupchatLeftUser),
            loadingChat: false,
            oldState: state,
          ));
          chatCubit.replaceOrAdd(chatState: state);
        }
      },
    );
  }

  Future loadMessages() async {
    emit(CurrentChatState.merge(
      oldState: state,
      loadingMessages: true,
    ));
    final Either<NotificationAlert, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      getMessagesFilter: GetMessagesFilter(
        groupchatTo: state.currentChat.id,
      ),
      limitOffsetFilter: LimitOffsetFilter(
        limit: 20,
        offset: state.messages.length,
      ),
    );

    messagesOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          CurrentChatState.merge(oldState: state, loadingMessages: false),
        );
      },
      (messages) {
        emit(CurrentChatState.merge(
          messages: List.from(state.messages)..addAll(messages),
          loadingMessages: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chatState: state);
      },
    );
  }

  MessageEntity addMessage({required MessageEntity message}) {
    emit(CurrentChatState.merge(
      messages: List.from(state.messages)..add(message),
      oldState: state,
    ));
    chatCubit.replaceOrAdd(chatState: state);
    return message;
  }
}
