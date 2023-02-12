import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_left_groupchat_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_private_events_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'current_chat_state.dart';

class CurrentChatCubit extends Cubit<CurrentChatState> {
  final ChatCubit chatCubit;
  final PrivateEventCubit privateEventCubit;
  final UserCubit userCubit;
  final ChatUseCases chatUseCases;
  final PrivateEventUseCases privateEventUseCases;

  CurrentChatCubit(
    super.initialState, {
    required this.privateEventCubit,
    required this.privateEventUseCases,
    required this.chatCubit,
    required this.userCubit,
    required this.chatUseCases,
  });

  Future getPrivateEventsViaApi() async {
    emit(CurrentChatNormal(
      currentChat: state.currentChat,
      privateEvents: state.privateEvents,
      loadingPrivateEvents: true,
      usersWithGroupchatUserData: state.usersWithGroupchatUserData,
      usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
      loadingChat: state.loadingChat,
    ));

    final Either<Failure, List<PrivateEventEntity>> privateEventsOrFailute =
        await privateEventUseCases.getPrivateEventsViaApi(
      getPrivateEventsFilter: GetPrivateEventsFilter(
        connectedGroupchat: state.currentChat.id,
      ),
    );

    privateEventsOrFailute.fold(
      (error) => emit(CurrentChatError(
        currentChat: state.currentChat,
        loadingChat: state.loadingChat,
        usersWithGroupchatUserData: state.usersWithGroupchatUserData,
        loadingPrivateEvents: false,
        privateEvents: state.privateEvents,
        usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
        message: mapFailureToMessage(error),
        title: "Fehler Private Events",
      )),
      (privateEvents) {
        privateEventCubit.mergeOrAddMultiple(
          privateEvents: privateEvents,
        );
        setPrivateEventFromPrivateEventCubit(
          loadingPrivateEventsFromApi: false,
        );
      },
    );
  }

  void setPrivateEventFromPrivateEventCubit({
    bool? loadingPrivateEventsFromApi,
  }) {
    emit(CurrentChatNormal(
      currentChat: state.currentChat,
      loadingChat: state.loadingChat,
      usersWithGroupchatUserData: state.usersWithGroupchatUserData,
      loadingPrivateEvents:
          loadingPrivateEventsFromApi ?? state.loadingPrivateEvents,
      privateEvents: privateEventCubit.state.privateEvents
          .where(
            (element) => element.connectedGroupchat == state.currentChat.id,
          )
          .toList(),
      usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
    ));
  }

  Future getGroupchatUsersViaApi() async {
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
      loadingPrivateEvents: state.loadingPrivateEvents,
      privateEvents: state.privateEvents,
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
      loadingPrivateEvents: state.loadingPrivateEvents,
      privateEvents: state.privateEvents,
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
          loadingPrivateEvents: state.loadingPrivateEvents,
          privateEvents: state.privateEvents,
          title: "Fehler",
          message: mapFailureToMessage(error),
          loadingChat: false,
        ));
      },
      (groupchat) async {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(CurrentChatNormal(
          currentChat: mergedChat,
          loadingChat: false,
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          loadingPrivateEvents: state.loadingPrivateEvents,
          privateEvents: state.privateEvents,
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
      loadingPrivateEvents: state.loadingPrivateEvents,
      privateEvents: state.privateEvents,
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
      loadingPrivateEvents: state.loadingPrivateEvents,
      privateEvents: state.privateEvents,
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
          loadingPrivateEvents: state.loadingPrivateEvents,
          privateEvents: state.privateEvents,
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
          loadingPrivateEvents: state.loadingPrivateEvents,
          privateEvents: state.privateEvents,
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
      loadingPrivateEvents: state.loadingPrivateEvents,
      privateEvents: state.privateEvents,
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
          loadingPrivateEvents: state.loadingPrivateEvents,
          privateEvents: state.privateEvents,
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
          loadingPrivateEvents: state.loadingPrivateEvents,
          privateEvents: state.privateEvents,
        ));
        setGroupchatUsers();
      },
    );
  }
}
