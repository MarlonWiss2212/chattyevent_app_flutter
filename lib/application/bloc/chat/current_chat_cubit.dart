import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_left_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'current_chat_state.dart';

class CurrentChatCubit extends Cubit<CurrentChatState> {
  final ChatCubit chatCubit;
  final UserCubit userCubit;
  final ChatUseCases chatUseCases;

  CurrentChatCubit(
    super.initialState, {
    required this.chatCubit,
    required this.userCubit,
    required this.chatUseCases,
  });

  void setGroupchatUsers() {
    List<UserWithGroupchatUserData> usersToEmit = [];
    List<UserWithLeftGroupchatUserData> leftUsersToEmit = [];

    if (state.currentChat.users != null) {
      for (final groupchatUser in state.currentChat.users!) {
        final foundUser = userCubit.state.users.firstWhere(
          (element) => element.id == groupchatUser.userId,
          orElse: () => UserEntity(id: ""),
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
          orElse: () => UserEntity(id: ""),
        );
        leftUsersToEmit.add(
          UserWithLeftGroupchatUserData.fromUserEntity(
            user: foundUser,
            leftGroupchatUser: groupchatLeftUser,
          ),
        );
      }
    }

    emit(CurrentChatNormal(
      usersWithGroupchatUserData: usersToEmit,
      usersWithLeftGroupchatUserData: leftUsersToEmit,
      loadingChat: state.loadingChat,
      currentChat: state.currentChat,
    ));
  }

  Future getCurrentChatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    emit(CurrentChatNormal(
      currentChat: state.currentChat,
      loadingChat: true,
      usersWithGroupchatUserData: state.usersWithGroupchatUserData,
      usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
    ));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          currentChat: state.currentChat,
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
          title: "Fehler",
          message: mapFailureToMessage(error),
          loadingChat: false,
        ));
      },
      (groupchat) {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(CurrentChatNormal(
          currentChat: mergedChat,
          loadingChat: false,
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
        ));
        setGroupchatUsers();
      },
    );
  }

  void setCurrentChat({required GroupchatEntity groupchat}) {
    emit(CurrentChatNormal(
      currentChat: groupchat,
      loadingChat: state.loadingChat,
      usersWithGroupchatUserData: state.usersWithGroupchatUserData,
      usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
    ));
    setGroupchatUsers();
  }

  Future addUserToChat({
    required String groupchatId,
    required String userIdToAdd,
  }) async {
    emit(CurrentChatNormal(
      currentChat: state.currentChat,
      loadingChat: true,
      usersWithGroupchatUserData: state.usersWithGroupchatUserData,
      usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
    ));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.addUserToGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToAdd: userIdToAdd,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
          loadingChat: false,
          currentChat: state.currentChat,
          message: "Fehler",
          title: mapFailureToMessage(error),
        ));
      },
      (groupchat) {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(CurrentChatNormal(
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
          currentChat: mergedChat,
          loadingChat: false,
        ));
        setGroupchatUsers();
      },
    );
  }

  Future deleteUserFromChatEvent({
    required String groupchatId,
    required String userIdToDelete,
  }) async {
    emit(CurrentChatNormal(
      usersWithGroupchatUserData: state.usersWithGroupchatUserData,
      usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
      currentChat: state.currentChat,
      loadingChat: true,
    ));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.deleteUserFromGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToDelete: userIdToDelete,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
          loadingChat: false,
          currentChat: state.currentChat,
          message: mapFailureToMessage(error),
          title: "Fehler",
        ));
      },
      (groupchat) {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(CurrentChatNormal(
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
          currentChat: mergedChat,
          loadingChat: false,
        ));
        setGroupchatUsers();
      },
    );
  }
}
