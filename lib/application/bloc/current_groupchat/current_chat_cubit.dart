import 'dart:async';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/request/request_type_enum.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat_add_user.response.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/request_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_one_request_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_requests_filter.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_left_user/create_groupchat_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/create_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/update_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_to_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_events_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/groupchat_user/find_one_groupchat_user_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-data.response.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-users-and-left-users.response.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/event_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'current_chat_state.dart';

class CurrentGroupchatCubit extends Cubit<CurrentGroupchatState> {
  final AuthCubit authCubit;
  final ChatCubit chatCubit;
  final MessageStreamCubit messageStreamCubit;
  final NotificationCubit notificationCubit;

  final RequestUseCases requestUseCases;
  final GroupchatUseCases groupchatUseCases;
  final MessageUseCases messageUseCases;
  final EventUseCases eventUseCases;

  CurrentGroupchatCubit(
    super.initialState, {
    required this.messageStreamCubit,
    required this.requestUseCases,
    required this.authCubit,
    required this.groupchatUseCases,
    required this.eventUseCases,
    required this.chatCubit,
    required this.notificationCubit,
    required this.messageUseCases,
  }) {
    messageStreamCubit.stream.listen((event) {
      if (event.addedMessage?.groupchatTo == state.currentChat.id) {
        addMessage(message: event.addedMessage!);
      }
    });
  }

  @override
  void emit(
    CurrentGroupchatState state, {
    bool replaceOrAddInOtherCubits = true,
  }) {
    if (replaceOrAddInOtherCubits) {
      chatCubit.replaceOrAdd(chat: ChatEntity(groupchat: state.currentChat));
    }

    super.emit(state);
  }

  Future reloadGroupchatAndGroupchatUsersViaApi() async {
    emit(CurrentGroupchatState.merge(
        oldState: state,
        currentUserId: authCubit.state.currentUser.id,
        loadingChat: true));

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
        emit(CurrentGroupchatState.merge(
            oldState: state,
            currentUserId: authCubit.state.currentUser.id,
            loadingChat: false));
      },
      (data) {
        emit(CurrentGroupchatState.merge(
          currentChat: data.groupchat,
          users: data.groupchatUsers,
          leftUsers: data.groupchatLeftUsers,
          loadingChat: false,
          oldState: state,
          currentUserId: authCubit.state.currentUser.id,
        ));
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
            currentUserId: authCubit.state.currentUser.id,
            users: usersAndLeftUsers.groupchatUsers,
            leftUsers: usersAndLeftUsers.groupchatLeftUsers,
          ),
        );
      },
    );
  }

  Future getFutureConnectedPrivateEventsFromApi({
    bool reload = false,
  }) async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      currentUserId: authCubit.state.currentUser.id,
      loadingPrivateEvents: true,
    ));

    final privateEventsOrFailure = await eventUseCases.getEventsViaApi(
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.futureConnectedPrivateEvents.length > 20
                ? state.futureConnectedPrivateEvents.length
                : 20
            : 20,
        offset: reload ? 0 : state.futureConnectedPrivateEvents.length,
      ),
      findEventsFilter: FindEventsFilter(
        onlyFutureEvents: true,
        sortNewestDateFirst: false,
        groupchatTo: state.currentChat.id,
      ),
    );

    privateEventsOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(CurrentGroupchatState.merge(
          oldState: state,
          currentUserId: authCubit.state.currentUser.id,
          loadingPrivateEvents: false,
        ));
      },
      (events) {
        emit(CurrentGroupchatState.merge(
          oldState: state,
          currentUserId: authCubit.state.currentUser.id,
          loadingPrivateEvents: false,
        ));
        for (final event in events) {
          replaceOrAddFutureConnectedPrivateEvent(event: event);
        }
      },
    );
  }

  EventEntity replaceOrAddFutureConnectedPrivateEvent({
    required EventEntity event,
  }) {
    int foundIndex = state.futureConnectedPrivateEvents.indexWhere(
      (element) => element.id == event.id,
    );

    if (foundIndex != -1) {
      List<EventEntity> newPrivateEvents = state.futureConnectedPrivateEvents;
      newPrivateEvents[foundIndex] = event;

      emit(CurrentGroupchatState.merge(
        oldState: state,
        currentUserId: authCubit.state.currentUser.id,
        futureConnectedPrivateEvents: newPrivateEvents,
      ));
      return newPrivateEvents[foundIndex];
    } else {
      List<EventEntity> newPrivateEvents =
          List.from(state.futureConnectedPrivateEvents)..add(event);
      newPrivateEvents.sort((a, b) => a.eventDate.compareTo(b.eventDate));
      emit(CurrentGroupchatState.merge(
        oldState: state,
        currentUserId: authCubit.state.currentUser.id,
        futureConnectedPrivateEvents: newPrivateEvents,
      ));
    }
    return event;
  }

  Future getCurrentChatViaApi() async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      currentUserId: authCubit.state.currentUser.id,
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
        emit(CurrentGroupchatState.merge(
            oldState: state,
            currentUserId: authCubit.state.currentUser.id,
            loadingChat: false));
      },
      (groupchat) async {
        emit(CurrentGroupchatState.merge(
          currentChat: groupchat,
          loadingChat: false,
          oldState: state,
          currentUserId: authCubit.state.currentUser.id,
        ));
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
        emit(
          CurrentGroupchatState.merge(
            currentChat: groupchat,
            oldState: state,
            currentUserId: authCubit.state.currentUser.id,
          ),
        );
      },
    );
  }

  Future addUserToChat({required String userId}) async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      currentUserId: authCubit.state.currentUser.id,
      loadingChat: true,
    ));
    final Either<NotificationAlert, GroupchatAddUserResponse>
        groupchatOrFailure = await groupchatUseCases.addUserToGroupchatViaApi(
      createGroupchatUserDto: CreateGroupchatUserDto(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          CurrentGroupchatState.merge(
            oldState: state,
            currentUserId: authCubit.state.currentUser.id,
            loadingChat: false,
          ),
        );
      },
      (groupchatUserOrRequest) {
        emit(CurrentGroupchatState.merge(
          oldState: state,
          currentUserId: authCubit.state.currentUser.id,
          loadingChat: false,
          users: groupchatUserOrRequest.groupchatUser != null
              ? [...state.users, groupchatUserOrRequest.groupchatUser!]
              : null,
          leftUsers: groupchatUserOrRequest.groupchatUser != null
              ? state.leftUsers
                  .where(
                    (element) =>
                        element.id != groupchatUserOrRequest.groupchatUser!.id,
                  )
                  .toList()
              : null,
          invitations: groupchatUserOrRequest.request != null
              ? [...state.invitations, groupchatUserOrRequest.request!]
              : state.invitations,
        ));
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
          currentUserId: authCubit.state.currentUser.id,
        ));
      },
    );
  }

  Future deleteUserFromChat({required String userId}) async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      currentUserId: authCubit.state.currentUser.id,
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
          CurrentGroupchatState.merge(
              oldState: state,
              currentUserId: authCubit.state.currentUser.id,
              loadingChat: false),
        );
      },
      (groupchatLeftUser) {
        if (groupchatLeftUser == null ||
            userId == authCubit.state.currentUser.id) {
          emit(CurrentGroupchatState.merge(
            currentUserLeftChat: true,
            loadingChat: false,
            oldState: state,
            currentUserId: authCubit.state.currentUser.id,
          ));
          chatCubit.delete(groupchatId: state.currentChat.id);
        } else {
          emit(CurrentGroupchatState.merge(
            users: List.from(state.users)
              ..removeWhere((element) => element.id == groupchatLeftUser.id),
            leftUsers: List.from(state.leftUsers)..add(groupchatLeftUser),
            loadingChat: false,
            oldState: state,
            currentUserId: authCubit.state.currentUser.id,
          ));
        }
      },
    );
  }

  Future loadMessages({bool reload = false}) async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      currentUserId: authCubit.state.currentUser.id,
      loadingMessages: true,
    ));

    final Either<NotificationAlert, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      findMessagesFilter: FindMessagesFilter(
        groupchatTo: state.currentChat.id,
      ),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.messages.length > 50
                ? state.messages.length
                : 50
            : 50,
        offset: reload ? 0 : state.messages.length,
      ),
    );

    messagesOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emit(
          CurrentGroupchatState.merge(
            oldState: state,
            currentUserId: authCubit.state.currentUser.id,
            loadingMessages: false,
          ),
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
          currentUserId: authCubit.state.currentUser.id,
        ));
      },
    );
  }

  Future<void> getInvitationsViaApi({bool reload = false}) async {
    emit(CurrentGroupchatState.merge(
      oldState: state,
      currentUserId: authCubit.state.currentUser.id,
      loadingInvitations: true,
    ));

    final requestsOrFailure = await requestUseCases.getRequestsViaApi(
      findRequestsFilter: FindRequestsFilter(
        groupchatTo: state.currentChat.id,
        type: RequestTypeEnum.invitation,
      ),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit:
                  state.invitations.length < 20 ? 20 : state.invitations.length,
              offset: 0,
            )
          : LimitOffsetFilter(
              limit: 20,
              offset: state.invitations.length,
            ),
    );
    requestsOrFailure.fold(
      (alert) {
        emit(CurrentGroupchatState.merge(
          oldState: state,
          currentUserId: authCubit.state.currentUser.id,
          loadingInvitations: false,
        ));
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (requests) {
        if (reload) {
          emit(CurrentGroupchatState.merge(
            oldState: state,
            currentUserId: authCubit.state.currentUser.id,
            loadingInvitations: false,
            invitations: requests,
          ));
        } else {
          emit(CurrentGroupchatState.merge(
            oldState: state,
            currentUserId: authCubit.state.currentUser.id,
            loadingInvitations: false,
            invitations: [...state.invitations, ...requests],
          ));
        }
      },
    );
  }

  Future<void> deleteRequestViaApiAndReloadRequests({
    required RequestEntity request,
  }) async {
    final deletedOrFailure = await requestUseCases.deleteRequestViaApi(
      findOneRequestFilter: FindOneRequestFilter(id: request.id),
    );

    await deletedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (_) async {
        emit(CurrentGroupchatState.merge(
          oldState: state,
          currentUserId: authCubit.state.currentUser.id,
          invitations: state.invitations
              .where((element) => element.id != request.id)
              .toList(),
        ));

        //TODO: check later if i have to relaod invitations Or Join Requests
        await getInvitationsViaApi(reload: true);
      },
    );
  }

  MessageEntity addMessage({
    required MessageEntity message,
    bool replaceOrAddInOtherCubits = false,
  }) {
    emit(
      CurrentGroupchatState.merge(
        messages: List.from(state.messages)..add(message),
        oldState: state,
        currentUserId: authCubit.state.currentUser.id,
      ),
      replaceOrAddInOtherCubits: false,
    );
    return message;
  }
}
