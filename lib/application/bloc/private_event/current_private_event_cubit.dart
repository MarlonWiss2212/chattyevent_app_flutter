import 'dart:collection';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'current_private_event_state.dart';

class CurrentPrivateEventCubit extends Cubit<CurrentPrivateEventState> {
  final PrivateEventCubit privateEventCubit;
  final ChatCubit chatCubit;
  final ShoppingListCubit shoppingListCubit;
  final UserCubit userCubit;

  final PrivateEventUseCases privateEventUseCases;
  final ChatUseCases chatUseCases;
  final ShoppingListItemUseCases shoppingListItemUseCases;

  CurrentPrivateEventCubit(
    super.initialState, {
    required this.userCubit,
    required this.shoppingListCubit,
    required this.privateEventCubit,
    required this.chatCubit,
    required this.chatUseCases,
    required this.shoppingListItemUseCases,
    required this.privateEventUseCases,
  });

  // optimize this later
  Future getPrivateEventUsersViaApi() async {
    await userCubit.getUsersViaApi();
    setPrivateEventUsers();
  }

  Future getPrivateEventAndGroupchatFromApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
    GetOneGroupchatFilter? getOneGroupchatFilter,
  }) async {
    await getCurrentPrivateEvent(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );
    if (getOneGroupchatFilter != null ||
        state.privateEvent.connectedGroupchat != null) {
      await getCurrentChatViaApi(
        getOneGroupchatFilter: getOneGroupchatFilter ??
            GetOneGroupchatFilter(
              id: state.privateEvent.connectedGroupchat!,
            ),
      );
    }
  }

  void setPrivateEventUsers() {
    List<UserWithPrivateEventUserData> usersToEmit = [];

    if (state.privateEvent.users != null) {
      for (final privateEventUser in state.privateEvent.users!) {
        final foundUser = userCubit.state.users.firstWhere(
          (element) => element.id == privateEventUser.userId,
          orElse: () => UserEntity(id: "", authId: ""),
        );
        final foundGroupchatUser = state.groupchat.users?.firstWhere(
          (element) => element.userId == privateEventUser.userId,
          orElse: () => GroupchatUserEntity(id: ""),
        );
        usersToEmit.add(
          UserWithPrivateEventUserData(
            user: foundUser,
            groupchatUser: foundGroupchatUser,
            privateEventUser: privateEventUser,
          ),
        );
      }
    }

    emitState(privateEventUsers: usersToEmit);
  }

  void setCurrentChatFromChatCubit({
    bool? loadingCurrentChatFromApi,
  }) {
    emitState(
      groupchat: chatCubit.state.chats.firstWhere(
        (element) => element.id == state.privateEvent.connectedGroupchat,
        orElse: () => state.groupchat,
      ),
      loadingGroupchat: loadingCurrentChatFromApi,
    );
  }

  Future getCurrentChatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    emitState(loadingGroupchat: true);
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );

    await groupchatOrFailure.fold(
      (error) {
        emitState(
          status: CurrentPrivateEventStateStatus.error,
          error: ErrorWithTitleAndMessage(
            title: "Get Groupchat Fehler",
            message: mapFailureToMessage(error),
          ),
          loadingGroupchat: false,
        );
      },
      (groupchat) async {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emitState(groupchat: mergedChat, loadingGroupchat: false);
        setPrivateEventUsers();
      },
    );
  }

  Future getCurrentPrivateEvent({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    emitState(loadingPrivateEvent: true);

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );

    privateEventOrFailure.fold(
      (error) {
        emitState(
          status: CurrentPrivateEventStateStatus.error,
          loadingPrivateEvent: false,
          error: ErrorWithTitleAndMessage(
            title: "Fehler Geradiges Event",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (privateEvent) {
        final mergedPrivateEvent = privateEventCubit.mergeOrAdd(
          privateEvent: privateEvent,
        );
        emitState(
          privateEvent: mergedPrivateEvent,
          loadingPrivateEvent: false,
        );
        setPrivateEventUsers();
      },
    );
  }

  Future updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
  }) async {
    emitState(loadingPrivateEvent: true);

    final Either<Failure, PrivateEventUserEntity> privateEventOrFailure =
        await privateEventUseCases.updatePrivateEventUser(
      privateEventId: state.privateEvent.id,
      updatePrivateEventUserDto: updatePrivateEventUserDto,
    );

    privateEventOrFailure.fold(
      (error) {
        emitState(
          status: CurrentPrivateEventStateStatus.error,
          loadingPrivateEvent: false,
          error: ErrorWithTitleAndMessage(
            title: "Fehler",
            message: mapFailureToMessage(error),
          ),
        );
      },
      (privateEventUser) {
        final newPrivateEvent = PrivateEventEntity.merge(
          setUsersFromOldEntity: true,
          newEntity: PrivateEventEntity(
              id: state.privateEvent.id, users: [privateEventUser]),
          oldEntity: state.privateEvent,
        );

        final mergedPrivateEvent = privateEventCubit.mergeOrAdd(
          privateEvent: newPrivateEvent,
        );

        emitState(
          loadingPrivateEvent: false,
          privateEvent: mergedPrivateEvent,
        );
        setPrivateEventUsers();
      },
    );
  }

  void emitState({
    PrivateEventEntity? privateEvent,
    List<UserWithPrivateEventUserData>? privateEventUsers,
    GroupchatEntity? groupchat,
    bool? loadingPrivateEvent,
    bool? loadingGroupchat,
    CurrentPrivateEventStateStatus? status,
    ErrorWithTitleAndMessage? error,
  }) {
    emit(CurrentPrivateEventState(
      privateEvent: privateEvent ?? state.privateEvent,
      privateEventUsers: privateEventUsers ?? state.privateEventUsers,
      groupchat: groupchat ?? state.groupchat,
      loadingPrivateEvent: loadingPrivateEvent ?? state.loadingPrivateEvent,
      loadingGroupchat: loadingGroupchat ?? state.loadingGroupchat,
      error: error ?? state.error,
      status: status ?? CurrentPrivateEventStateStatus.initial,
    ));
  }
}
