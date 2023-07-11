import 'dart:async';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_left_user/create_groupchat_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/create_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/update_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_to_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/added_message_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/find_private_events_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/groupchat_user/find_one_groupchat_user_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-data.response.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-users-and-left-users.response.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'current_chat_state.dart';

class CurrentGroupchatCubit extends Cubit<CurrentGroupchatState> {
  final AuthCubit authCubit;
  final ChatCubit chatCubit;
  final NotificationCubit notificationCubit;

  final GroupchatUseCases groupchatUseCases;
  final MessageUseCases messageUseCases;
  final PrivateEventUseCases privateEventUseCases;

  StreamSubscription<Either<NotificationAlert, MessageEntity>>? _subscription;

  CurrentGroupchatCubit(
    super.initialState, {
    required this.authCubit,
    required this.groupchatUseCases,
    required this.privateEventUseCases,
    required this.chatCubit,
    required this.notificationCubit,
    required this.messageUseCases,
  });

  @override
  Future<void> close() {
    _subscription?.cancel();
    _subscription = null;
    return super.close();
  }

  Future reloadGroupchatAndGroupchatUsersViaApi() async {
    emit(CurrentGroupchatState.merge(oldState: state, loadingChat: true));

    final Either<NotificationAlert, GroupchatAndGroupchatUsersResponse>
        response = await groupchatUseCases.getGroupchatDataViaApi(
      findOneGroupchatFilter: FindOneGroupchatFilter(
        groupchatId: state.currentChat.id,
      ),
      limitOffsetFilterMessages: LimitOffsetFilter(
        limit: 20,
        offset: state.messages.length,
      ),
    );

    response.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(CurrentGroupchatState.merge(oldState: state, loadingChat: false));
      },
      (data) {
        emit(CurrentGroupchatState.merge(
          currentChat: data.groupchat,
          users: data.groupchatUsers,
          currentUserIndex: data.groupchatUsers.indexWhere(
            (element) => element.id == authCubit.state.currentUser.id,
          ),
          leftUsers: data.groupchatLeftUsers,
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      },
    );
  }

  Future getGroupchatUsersViaApi() async {
    final Either<NotificationAlert, GroupchatUsersAndLeftUsersResponse>
        groupchatUsersAndLeftUsers =
        await groupchatUseCases.getGroupchatUsersAndLeftUsers(
      findOneGroupchatToFilter: FindOneGroupchatToFilter(
        groupchatTo: state.currentChat.id,
      ),
    );
    groupchatUsersAndLeftUsers.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (usersAndLeftUsers) {
        emit(
          CurrentGroupchatState.merge(
            oldState: state,
            users: usersAndLeftUsers.groupchatUsers,
            leftUsers: usersAndLeftUsers.groupchatLeftUsers,
            currentUserIndex: usersAndLeftUsers.groupchatUsers.indexWhere(
              (element) => element.id == authCubit.state.currentUser.id,
            ),
          ),
        );
        chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      },
    );
  }

  Future getFutureConnectedPrivateEventsFromApi({
    bool reload = false,
  }) async {
    emit(CurrentGroupchatState.merge(
        oldState: state, loadingPrivateEvents: true));

    final privateEventsOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi(
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.futureConnectedPrivateEvents.length > 20
                ? state.futureConnectedPrivateEvents.length
                : 20
            : 20,
        offset: reload ? 0 : state.futureConnectedPrivateEvents.length,
      ),
      findPrivateEventsFilter: FindPrivateEventsFilter(
        onlyFutureEvents: true,
        sortNewestDateFirst: false,
        groupchatTo: state.currentChat.id,
      ),
    );

    privateEventsOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          CurrentGroupchatState.merge(
              oldState: state, loadingPrivateEvents: false),
        );
      },
      (privateEvents) {
        emit(CurrentGroupchatState.merge(
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

      emit(CurrentGroupchatState.merge(
        oldState: state,
        futureConnectedPrivateEvents: newPrivateEvents,
      ));
      chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      return newPrivateEvents[foundIndex];
    } else {
      List<PrivateEventEntity> newPrivateEvents =
          List.from(state.futureConnectedPrivateEvents)..add(privateEvent);
      newPrivateEvents.sort((a, b) => a.eventDate.compareTo(b.eventDate));
      emit(CurrentGroupchatState.merge(
        oldState: state,
        futureConnectedPrivateEvents: newPrivateEvents,
      ));
      chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
    }
    return privateEvent;
  }

  Future getCurrentChatViaApi() async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      loadingChat: true,
    ));

    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await groupchatUseCases.getGroupchatViaApi(
      findOneGroupchatFilter: FindOneGroupchatFilter(
        groupchatId: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(CurrentGroupchatState.merge(oldState: state, loadingChat: false));
        chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      },
      (groupchat) async {
        emit(CurrentGroupchatState.merge(
          currentChat: groupchat,
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      },
    );
  }

  Future updateCurrentGroupchatViaApi({
    required UpdateGroupchatDto updateGroupchatDto,
  }) async {
    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await groupchatUseCases.updateGroupchatViaApi(
      findOneGroupchatFilter: FindOneGroupchatFilter(
        groupchatId: state.currentChat.id,
      ),
      updateGroupchatDto: updateGroupchatDto,
    );

    groupchatOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (groupchat) {
        emit(CurrentGroupchatState.merge(
            currentChat: groupchat, oldState: state));
        chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      },
    );
  }

  Future addUserToChat({required String userId}) async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      loadingChat: true,
    ));
    final Either<NotificationAlert, GroupchatUserEntity> groupchatOrFailure =
        await groupchatUseCases.addUserToGroupchatViaApi(
      createGroupchatUserDto: CreateGroupchatUserDto(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(CurrentGroupchatState.merge(oldState: state, loadingChat: false));
      },
      (groupchatUser) {
        emit(CurrentGroupchatState.merge(
          leftUsers: List.from(state.leftUsers)
            ..removeWhere((element) => element.id == groupchatUser.id),
          users: List.from(state.users)..add(groupchatUser),
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      },
    );
  }

  Future updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required String userId,
  }) async {
    final updatedUserOrFailure =
        await groupchatUseCases.updateGroupchatUserViaApi(
      updateGroupchatUserDto: updateGroupchatUserDto,
      findOneGroupchatUserFilter: FindOneGroupchatUserFilter(
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

        emit(CurrentGroupchatState.merge(
          users: newGroupchatUsers,
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      },
    );
  }

  Future deleteUserFromChat({required String userId}) async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      loadingChat: true,
    ));
    final Either<NotificationAlert, GroupchatLeftUserEntity?>
        groupchatOrFailure =
        await groupchatUseCases.deleteUserFromGroupchatViaApi(
      createGroupchatLeftUserDto: CreateGroupchatLeftUserDto(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          CurrentGroupchatState.merge(oldState: state, loadingChat: false),
        );
        chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      },
      (groupchatLeftUser) {
        if (groupchatLeftUser == null ||
            userId == authCubit.state.currentUser.id) {
          emit(CurrentGroupchatState.merge(
            currentUserLeftChat: true,
            loadingChat: false,
            oldState: state,
          ));
          chatCubit.delete(groupchatId: state.currentChat.id);
        } else {
          emit(CurrentGroupchatState.merge(
            users: List.from(state.users)
              ..removeWhere((element) => element.id == groupchatLeftUser.id),
            leftUsers: List.from(state.leftUsers)..add(groupchatLeftUser),
            loadingChat: false,
            oldState: state,
          ));
          chatCubit.replaceOrAdd(
              chat: ChatEntity(groupchat: state.currentChat));
        }
      },
    );
  }

  void listenToMessages() {
    final eitherAlertOrStream = messageUseCases.getMessagesRealtimeViaApi(
      addedMessageFilter: AddedMessageFilter(
        groupchatTo: state.currentChat.id,
      ),
    );

    eitherAlertOrStream.fold(
      (alert) => notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Nachrichten error",
          message:
              "Fehler beim herstellen einer Verbindung um live nachrichten zu erhalten",
        ),
      ),
      (subscription) {
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
      },
    );
  }

  Future loadMessages({bool reload = false}) async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      loadingMessages: true,
    ));

    final Either<NotificationAlert, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      findMessagesFilter: FindMessagesFilter(
        groupchatTo: state.currentChat.id,
      ),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.messages.length > 20
                ? state.messages.length
                : 20
            : 20,
        offset: reload ? 0 : state.messages.length,
      ),
    );

    messagesOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          CurrentGroupchatState.merge(oldState: state, loadingMessages: false),
        );
      },
      (messages) {
        List<MessageEntity> newMessages = [];
        if (reload == false) {
          newMessages = [...state.messages, ...messages];
        } else {
          newMessages = messages;
        }

        emit(CurrentGroupchatState.merge(
          messages: newMessages,
          loadingMessages: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
      },
    );
  }

  MessageEntity addMessage({required MessageEntity message}) {
    emit(CurrentGroupchatState.merge(
      messages: List.from(state.messages)..add(message),
      oldState: state,
    ));
    chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
    return message;
  }
}
