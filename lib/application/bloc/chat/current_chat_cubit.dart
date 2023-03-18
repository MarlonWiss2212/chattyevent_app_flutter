import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_left_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_filter.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_left_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';

part 'current_chat_state.dart';

class CurrentChatCubit extends Cubit<CurrentChatState> {
  final AuthCubit authCubit;
  final ChatCubit chatCubit;
  final UserCubit userCubit;
  final ChatUseCases chatUseCases;
  final MessageUseCases messageUseCases;

  CurrentChatCubit(
    super.initialState, {
    required this.authCubit,
    required this.messageUseCases,
    required this.chatCubit,
    required this.userCubit,
    required this.chatUseCases,
  });

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
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emitState(
          loadingChat: false,
          currentChat: mergedChat,
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
        final mergedChat = chatCubit.mergeOrAdd(
          groupchat: GroupchatEntity.merge(
            newEntity: GroupchatEntity(
              id: state.currentChat.id,
              leftUsers: List.from(state.currentChat.leftUsers ?? [])
                ..removeWhere(
                  (element) => element.userId == groupchatUser.userId,
                ),
              users: List.from(state.currentChat.users ?? [])
                ..add(groupchatUser),
            ),
            oldEntity: state.currentChat,
          ),
        );
        emitState(loadingChat: false, currentChat: mergedChat);
        setGroupchatUsers();
      },
    );
  }

  Future deleteUserFromChat({required String userId}) async {
    emitState(loadingChat: true);

    final Either<Failure, GroupchatLeftUserEntity> groupchatOrFailure =
        await chatUseCases.deleteUserFromGroupchatViaApi(
      createGroupchatLeftUserDto: CreateGroupchatLeftUserDto(
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
          final mergedChat = chatCubit.mergeOrAdd(
            groupchat: GroupchatEntity.merge(
              newEntity: GroupchatEntity(
                id: state.currentChat.id,
                users: List.from(state.currentChat.users ?? [])
                  ..removeWhere(
                    (element) => element.userId == groupchatLeftUser.userId,
                  ),
                leftUsers: List.from(state.currentChat.leftUsers ?? [])
                  ..add(groupchatLeftUser),
              ),
              oldEntity: state.currentChat,
            ),
          );
          emitState(loadingChat: false, currentChat: mergedChat);
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
        limitFilter: LimitFilter(
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
          currentChat: chatCubit.mergeOrAdd(
            groupchat: GroupchatEntity(
              id: state.currentChat.id,
              messages: messages,
            ),
          ),
        );
      },
    );
  }

  /// the message will automaticly updated in the groupchat cubit as well
  MessageEntity mergeOrAddMessage({required MessageEntity message}) {
    if (state.currentChat.messages != null) {
      int foundIndex = state.currentChat.messages!.indexWhere(
        (element) => element.id == message.id,
      );

      if (foundIndex != -1) {
        List<MessageEntity> newMessages = state.currentChat.messages!;
        newMessages[foundIndex] = MessageEntity.merge(
          newEntity: message,
          oldEntity: state.currentChat.messages![foundIndex],
        );
        emitState(
          currentChat: chatCubit.mergeOrAdd(
            groupchat: GroupchatEntity(
              id: state.currentChat.id,
              messages: newMessages,
            ),
          ),
        );
        return newMessages[foundIndex];
      } else {
        emitState(
          currentChat: chatCubit.mergeOrAdd(
            groupchat: GroupchatEntity(
              id: state.currentChat.id,
              messages: List.from(state.currentChat.messages!)..add(message),
            ),
          ),
        );
      }
    } else {
      emitState(
        currentChat: chatCubit.mergeOrAdd(
          groupchat: GroupchatEntity(
            id: state.currentChat.id,
            messages: [message],
          ),
        ),
      );
    }
    return message;
  }

  void emitState({
    GroupchatEntity? currentChat,
    bool? currentUserLeftChat,
    bool? loadingChat,
    bool? loadingMessages,
    bool? showError,
    List<UserWithGroupchatUserData>? usersWithGroupchatUserData,
    List<UserWithLeftGroupchatUserData>? usersWithLeftGroupchatUserData,
    ErrorWithTitleAndMessage? error,
  }) {
    emit(
      CurrentChatState(
        currentUserLeftChat: currentUserLeftChat ?? state.currentUserLeftChat,
        showError: showError ?? false,
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
