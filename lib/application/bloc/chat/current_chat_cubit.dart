import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/added_message_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_messages_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_private_events_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_left_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'current_chat_state.dart';

class CurrentChatCubit extends Cubit<CurrentChatState> {
  final AuthCubit authCubit;
  final ChatCubit chatCubit;
  final UserCubit userCubit;

  final ChatUseCases chatUseCases;
  final MessageUseCases messageUseCases;
  final PrivateEventUseCases privateEventUseCases;

  StreamSubscription<Either<Failure, MessageEntity>>? _subscription;

  CurrentChatCubit(
    super.initialState, {
    required this.authCubit,
    required this.messageUseCases,
    required this.privateEventUseCases,
    required this.chatCubit,
    required this.userCubit,
    required this.chatUseCases,
  });

  void listenToMessages() {
    final subscription = messageUseCases.getMessagesRealtimeViaApi(
      addedMessageFilter: AddedMessageFilter(
        groupchatTo: state.currentChat.id,
      ),
    );

    _subscription = subscription.listen((event) {
      event.fold(
        (error) => emitState(
          error: ErrorWithTitleAndMessage(
            title: "Nachrichten error",
            message:
                "Fehler beim herstellen einer Verbindung um live nachrichten zu erhalten",
          ),
          showError: true,
        ),
        (message) => addMessage(
          message: message,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future getGroupchatUsersViaApi() async {
    /// optimize this
    await userCubit.getUsersViaApi();
    setGroupchatUsers();
  }

  void setGroupchatUsers() {
    List<UserWithGroupchatUserData> usersToEmit = [];
    List<UserWithLeftGroupchatUserData> leftUsersToEmit = [];

    if (state.currentChat.users != null) {
      for (final groupchatUser in state.currentChat.users!) {
        final foundUser = userCubit.state.users.firstWhere(
          (element) => element.id == groupchatUser.userId,
          orElse: () => UserEntity(
            id: groupchatUser.userId ?? "",
            authId: "",
          ),
        );
        usersToEmit.add(
          UserWithGroupchatUserData.fromUserEntity(
            user: foundUser,
            groupchatUser: groupchatUser,
          ),
        );
      }
    }

    if (state.currentChat.leftUsers != null) {
      for (final groupchatLeftUser in state.currentChat.leftUsers!) {
        final foundUser = userCubit.state.users.firstWhere(
          (element) => element.id == groupchatLeftUser.userId,
          orElse: () => UserEntity(
            id: groupchatLeftUser.userId ?? "",
            authId: "",
          ),
        );
        leftUsersToEmit.add(
          UserWithLeftGroupchatUserData.fromUserEntity(
            user: foundUser,
            leftGroupchatUser: groupchatLeftUser,
          ),
        );
      }
    }

    emitState(
      usersWithGroupchatUserData: usersToEmit,
      usersWithLeftGroupchatUserData: leftUsersToEmit,
    );
  }

  Future getFutureConnectedPrivateEventsFromApi({
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    emitState(loadingPrivateEvents: true);

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
      (error) => emitState(
        error: ErrorWithTitleAndMessage(
          title: "Get Future Private Evnts error",
          message: mapFailureToMessage(
            error,
          ),
        ),
        loadingPrivateEvents: false,
      ),
      (privateEvents) {
        emitState(loadingPrivateEvents: false);
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
      emitState(futureConnectedPrivateEvents: newPrivateEvents);
      return newPrivateEvents[foundIndex];
    } else {
      List<PrivateEventEntity> newList =
          List.from(state.futureConnectedPrivateEvents)..add(privateEvent);
      newList.sort(
        (a, b) => a.eventDate!.compareTo(b.eventDate!),
      );
      emitState(futureConnectedPrivateEvents: newList);
    }
    return privateEvent;
  }

  Future getCurrentChatViaApi() async {
    emitState(loadingChat: true);

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: GetOneGroupchatFilter(id: state.currentChat.id),
    );

    groupchatOrFailure.fold(
      (error) {
        emitState(
          error: ErrorWithTitleAndMessage(
            title: "Fehler",
            message: mapFailureToMessage(error),
          ),
          showError: true,
          loadingChat: false,
        );
      },
      (groupchat) async {
        final replacedGroupchat = chatCubit.replaceOrAdd(
          groupchat: groupchat,
          setLeftUsersFromOldEntity: false,
          setMessagesFromOldEntity: true,
          setUsersFromOldEntity: false,
        );
        emitState(
          loadingChat: false,
          currentChat: replacedGroupchat,
        );
        setGroupchatUsers();
      },
    );
  }

  Future addUserToChat({required String userId}) async {
    emitState(loadingChat: true);

    final Either<Failure, GroupchatUserEntity> groupchatOrFailure =
        await chatUseCases.addUserToGroupchatViaApi(
      createGroupchatUserDto: CreateGroupchatUserDto(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (error) {
        emitState(
          error: ErrorWithTitleAndMessage(
            title: "Fehler",
            message: mapFailureToMessage(error),
          ),
          showError: true,
          loadingChat: false,
        );
      },
      (groupchatUser) {
        final replacedGroupchat = chatCubit.replaceOrAdd(
          groupchat: GroupchatEntity(
            id: state.currentChat.id,
            leftUsers: List.from(state.currentChat.leftUsers ?? [])
              ..removeWhere(
                (element) => element.userId == groupchatUser.userId,
              ),
            users: [groupchatUser],
          ),
          setLeftUsersFromOldEntity: false,
          setUsersFromOldEntity: true,
          setMessagesFromOldEntity: true,
        );
        emitState(loadingChat: false, currentChat: replacedGroupchat);
        setGroupchatUsers();
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
      (error) => emitState(
        error: ErrorWithTitleAndMessage(
          title: "Fehler Update User",
          message: mapFailureToMessage(error),
        ),
        showError: true,
      ),
      (groupchatUser) {
        List<GroupchatUserEntity> newGroupchatUsers =
            state.currentChat.users ?? [];

        int foundIndex = newGroupchatUsers.indexWhere(
          (element) => element.id == groupchatUser.id,
        );
        if (foundIndex != -1) {
          newGroupchatUsers[foundIndex] = groupchatUser;
        } else {
          newGroupchatUsers.add(groupchatUser);
        }
        final replacedGroupchat = chatCubit.replaceOrAdd(
          groupchat: GroupchatEntity(
            id: state.currentChat.id,
            users: newGroupchatUsers,
          ),
          setLeftUsersFromOldEntity: true,
          setUsersFromOldEntity: false,
          setMessagesFromOldEntity: true,
        );
        emitState(loadingChat: false, currentChat: replacedGroupchat);
        setGroupchatUsers();
      },
    );
  }

  Future deleteUserFromChat({required String userId}) async {
    emitState(loadingChat: true);

    final Either<Failure, GroupchatLeftUserEntity> groupchatOrFailure =
        await chatUseCases.deleteUserFromGroupchatViaApi(
      getOneGroupchatUserFilter: GetOneGroupchatUserFilter(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (error) {
        emitState(
          error: ErrorWithTitleAndMessage(
            title: "Fehler",
            message: mapFailureToMessage(error),
          ),
          showError: true,
          loadingChat: false,
        );
      },
      (groupchatLeftUser) {
        if (userId == authCubit.state.currentUser.id) {
          chatCubit.delete(groupchatId: state.currentChat.id);
          emitState(loadingChat: false, currentUserLeftChat: true);
        } else {
          final replacedGroupchat = chatCubit.replaceOrAdd(
            groupchat: GroupchatEntity(
              id: state.currentChat.id,
              users: List.from(state.currentChat.users ?? [])
                ..removeWhere(
                  (element) => element.userId == groupchatLeftUser.userId,
                ),
              leftUsers: [groupchatLeftUser],
            ),
            setLeftUsersFromOldEntity: true,
            setUsersFromOldEntity: false,
            setMessagesFromOldEntity: true,
          );
          emitState(loadingChat: false, currentChat: replacedGroupchat);
          setGroupchatUsers();
        }
      },
    );
  }

  Future loadMessages() async {
    emitState(loadingMessages: true);

    final Either<Failure, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      getMessagesFilter: GetMessagesFilter(
        groupchatTo: state.currentChat.id,
        limitOffsetFilter: LimitOffsetFilterOptional(
          limit: 20,
          offset: state.currentChat.messages != null
              ? state.currentChat.messages!.length
              : 0,
        ),
      ),
    );

    messagesOrFailure.fold(
      (error) {
        emitState(
          showError: true,
          loadingMessages: false,
          error: ErrorWithTitleAndMessage(
            title: "Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (messages) {
        emitState(
          loadingMessages: false,
          currentChat: chatCubit.replaceOrAdd(
            groupchat: GroupchatEntity(
              id: state.currentChat.id,
              messages: messages,
            ),
            setLeftUsersFromOldEntity: true,
            setUsersFromOldEntity: true,
            setMessagesFromOldEntity: true,
          ),
        );
      },
    );
  }

  /// the message will automaticly updated in the groupchat cubit as well
  MessageEntity addMessage({required MessageEntity message}) {
    List<MessageEntity> messages = state.currentChat.messages != null
        ? (List.from(state.currentChat.messages!)..add(message))
        : [message];
    emitState(
      currentChat: chatCubit.replaceOrAdd(
        groupchat: GroupchatEntity(
          id: state.currentChat.id,
          messages: messages,
        ),
        setMessagesFromOldEntity: false,
        setLeftUsersFromOldEntity: true,
        setUsersFromOldEntity: true,
      ),
    );

    return message;
  }

  void emitState({
    GroupchatEntity? currentChat,
    List<PrivateEventEntity>? futureConnectedPrivateEvents,
    bool? currentUserLeftChat,
    bool? loadingChat,
    bool? loadingMessages,
    bool? loadingPrivateEvents,
    bool? showError,
    List<UserWithGroupchatUserData>? usersWithGroupchatUserData,
    List<UserWithLeftGroupchatUserData>? usersWithLeftGroupchatUserData,
    ErrorWithTitleAndMessage? error,
  }) {
    emit(
      CurrentChatState(
        currentUserLeftChat: currentUserLeftChat ?? state.currentUserLeftChat,
        futureConnectedPrivateEvents:
            futureConnectedPrivateEvents ?? state.futureConnectedPrivateEvents,
        showError: showError ?? false,
        loadingPrivateEvents:
            loadingPrivateEvents ?? state.loadingPrivateEvents,
        currentChat: currentChat ?? state.currentChat,
        loadingChat: loadingChat ?? state.loadingChat,
        loadingMessages: loadingMessages ?? state.loadingMessages,
        usersWithGroupchatUserData:
            usersWithGroupchatUserData ?? state.usersWithGroupchatUserData,
        usersWithLeftGroupchatUserData: usersWithLeftGroupchatUserData ??
            state.usersWithLeftGroupchatUserData,
        error: error ?? state.error,
      ),
    );
  }
}
