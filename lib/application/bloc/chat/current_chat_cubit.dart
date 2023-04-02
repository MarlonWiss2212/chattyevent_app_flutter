import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
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
        (error) => emit(CurrentChatState.merge(
          oldState: state,
          error: ErrorWithTitleAndMessage(
            title: "Nachrichten error",
            message:
                "Fehler beim herstellen einer Verbindung um live nachrichten zu erhalten",
          ),
          showError: true,
        )),
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

    emit(CurrentChatState.merge(
      oldState: state,
      users: usersToEmit,
      leftUsers: leftUsersToEmit,
      currentUserIndex: usersToEmit.indexWhere(
        (element) => element.authId == authCubit.state.currentUser.authId,
      ),
    ));
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
      (error) => emit(CurrentChatState.merge(
        oldState: state,
        error: ErrorWithTitleAndMessage(
          title: "Get Future Private Evnts error",
          message: mapFailureToMessage(
            error,
          ),
        ),
        loadingPrivateEvents: false,
        showError: true,
      )),
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

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: GetOneGroupchatFilter(id: state.currentChat.id),
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatState.merge(
          oldState: state,
          error: ErrorWithTitleAndMessage(
            title: "Fehler Get Chat",
            message: mapFailureToMessage(error),
          ),
          showError: true,
          loadingChat: false,
        ));
      },
      (groupchat) async {
        emit(CurrentChatState.merge(
          currentChat: groupchat,
          mergeChatSetLeftUsersFromOldEntity: false,
          mergeChatSetMessagesFromOldEntity: true,
          mergeChatSetUsersFromOldEntity: false,
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chatState: state);
        setGroupchatUsers();
      },
    );
  }

  Future updateCurrentGroupchatViaApi({
    required UpdateGroupchatDto updateGroupchatDto,
  }) async {
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.updateGroupchatViaApi(
      getOneGroupchatFilter: GetOneGroupchatFilter(id: state.currentChat.id),
      updateGroupchatDto: updateGroupchatDto,
    );

    groupchatOrFailure.fold(
      (error) => emit(CurrentChatState.merge(
        oldState: state,
        showError: true,
        error: ErrorWithTitleAndMessage(
          title: "Update Chat Fehler",
          message: mapFailureToMessage(error),
        ),
      )),
      (groupchat) {
        emit(CurrentChatState.merge(
          currentChat: groupchat,
          mergeChatSetLeftUsersFromOldEntity: false,
          mergeChatSetUsersFromOldEntity: false,
          mergeChatSetMessagesFromOldEntity: true,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chatState: state);
        setGroupchatUsers();
      },
    );
  }

  Future addUserToChat({required String userId}) async {
    emit(CurrentChatState.merge(
      oldState: state,
      loadingChat: true,
    ));
    final Either<Failure, GroupchatUserEntity> groupchatOrFailure =
        await chatUseCases.addUserToGroupchatViaApi(
      createGroupchatUserDto: CreateGroupchatUserDto(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatState.merge(
          oldState: state,
          loadingChat: false,
          error: ErrorWithTitleAndMessage(
            title: "Fehler User hinzufügen",
            message: mapFailureToMessage(error),
          ),
          showError: true,
        ));
      },
      (groupchatUser) {
        emit(CurrentChatState.merge(
          currentChat: GroupchatEntity(
            id: state.currentChat.id,
            leftUsers: List.from(state.currentChat.leftUsers ?? [])
              ..removeWhere(
                (element) => element.userId == groupchatUser.userId,
              ),
            users: [groupchatUser],
          ),
          mergeChatSetLeftUsersFromOldEntity: false,
          mergeChatSetUsersFromOldEntity: true,
          mergeChatSetMessagesFromOldEntity: true,
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chatState: state);
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
      (error) => emit(CurrentChatState.merge(
        oldState: state,
        error: ErrorWithTitleAndMessage(
          title: "Fehler Update User",
          message: mapFailureToMessage(error),
        ),
        showError: true,
      )),
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

        emit(CurrentChatState.merge(
          currentChat: GroupchatEntity(
            id: state.currentChat.id,
            users: newGroupchatUsers,
          ),
          mergeChatSetLeftUsersFromOldEntity: true,
          mergeChatSetUsersFromOldEntity: false,
          mergeChatSetMessagesFromOldEntity: true,
          loadingChat: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chatState: state);
        setGroupchatUsers();
      },
    );
  }

  Future deleteUserFromChat({required String userId}) async {
    emit(CurrentChatState.merge(
      oldState: state,
      loadingChat: true,
    ));
    final Either<Failure, GroupchatLeftUserEntity?> groupchatOrFailure =
        await chatUseCases.deleteUserFromGroupchatViaApi(
      getOneGroupchatUserFilter: GetOneGroupchatUserFilter(
        userId: userId,
        groupchatTo: state.currentChat.id,
      ),
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatState.merge(
          oldState: state,
          showError: true,
          loadingChat: false,
          error: ErrorWithTitleAndMessage(
            title: "Fehler User Entfernen",
            message: mapFailureToMessage(error),
          ),
        ));
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
            currentChat: GroupchatEntity(
              id: state.currentChat.id,
              users: List.from(state.currentChat.users ?? [])
                ..removeWhere(
                  (element) => element.userId == groupchatLeftUser.userId,
                ),
              leftUsers: [groupchatLeftUser],
            ),
            mergeChatSetLeftUsersFromOldEntity: true,
            mergeChatSetUsersFromOldEntity: false,
            mergeChatSetMessagesFromOldEntity: true,
            loadingChat: false,
            oldState: state,
          ));
          chatCubit.replaceOrAdd(chatState: state);
          setGroupchatUsers();
        }
      },
    );
  }

  Future loadMessages() async {
    emit(CurrentChatState.merge(
      oldState: state,
      loadingMessages: true,
    ));
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
        emit(CurrentChatState.merge(
          oldState: state,
          showError: true,
          loadingMessages: false,
          error: ErrorWithTitleAndMessage(
            title: "Fehler Nachrichten laden",
            message: mapFailureToMessage(error),
          ),
        ));
      },
      (messages) {
        emit(CurrentChatState.merge(
          currentChat: GroupchatEntity(
            id: state.currentChat.id,
            messages: messages,
          ),
          mergeChatSetLeftUsersFromOldEntity: true,
          mergeChatSetUsersFromOldEntity: true,
          mergeChatSetMessagesFromOldEntity: true,
          loadingMessages: false,
          oldState: state,
        ));
        chatCubit.replaceOrAdd(chatState: state);
      },
    );
  }

  /// the message will automaticly updated in the groupchat cubit as well
  MessageEntity addMessage({required MessageEntity message}) {
    List<MessageEntity> messages = state.currentChat.messages != null
        ? (List.from(state.currentChat.messages!)..add(message))
        : [message];

    emit(CurrentChatState.merge(
      currentChat: GroupchatEntity(
        id: state.currentChat.id,
        messages: messages,
      ),
      mergeChatSetLeftUsersFromOldEntity: true,
      mergeChatSetUsersFromOldEntity: true,
      mergeChatSetMessagesFromOldEntity: false,
      oldState: state,
    ));
    chatCubit.replaceOrAdd(chatState: state);
    return message;
  }
}
