import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
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
          orElse: () => UserEntity(id: ""),
        );
        final foundGroupchatUser = state.groupchat.users?.firstWhere(
          (element) => element.id == privateEventUser.userId,
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

    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      privateEvent: state.privateEvent,
      privateEventUsers: usersToEmit,
      loadingGroupchat: state.loadingGroupchat,
      loadingPrivateEvent: state.loadingPrivateEvent,
    ));
  }

  void setCurrentChatFromChatCubit({
    bool? loadingCurrentChatFromApi,
  }) {
    emit(CurrentPrivateEventNormal(
      groupchat: chatCubit.state.chats.firstWhere(
        (element) => element.id == state.privateEvent.connectedGroupchat,
        orElse: () => state.groupchat,
      ),
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      loadingGroupchat: loadingCurrentChatFromApi ?? state.loadingGroupchat,
      loadingPrivateEvent: state.loadingPrivateEvent,
    ));
  }

  Future getCurrentChatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      loadingPrivateEvent: state.loadingPrivateEvent,
      loadingGroupchat: true,
    ));
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );

    await groupchatOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          groupchat: state.groupchat,
          privateEvent: state.privateEvent,
          privateEventUsers: state.privateEventUsers,
          loadingPrivateEvent: state.loadingPrivateEvent,
          loadingGroupchat: false,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (groupchat) async {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(CurrentPrivateEventNormal(
          groupchat: mergedChat,
          privateEvent: state.privateEvent,
          privateEventUsers: state.privateEventUsers,
          loadingPrivateEvent: state.loadingPrivateEvent,
          loadingGroupchat: false,
        ));
        setPrivateEventUsers();
      },
    );
  }

  Future getCurrentPrivateEvent({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      loadingPrivateEvent: true,
      loadingGroupchat: state.loadingGroupchat,
    ));

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );

    privateEventOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          groupchat: state.groupchat,
          privateEvent: state.privateEvent,
          privateEventUsers: state.privateEventUsers,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
          message: mapFailureToMessage(error),
          title: "Fehler Geradiges Event",
        ));
      },
      (privateEvent) {
        final mergedPrivateEvent = privateEventCubit.mergeOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventNormal(
          privateEvent: mergedPrivateEvent,
          privateEventUsers: state.privateEventUsers,
          groupchat: state.groupchat,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
        ));
        setPrivateEventUsers();
      },
    );
  }

  Future updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
  }) async {
    emit(CurrentPrivateEventNormal(
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      groupchat: state.groupchat,
      loadingPrivateEvent: true,
      loadingGroupchat: state.loadingGroupchat,
    ));

    final Either<Failure, PrivateEventUserEntity> privateEventOrFailure =
        await privateEventUseCases.updatePrivateEventUser(
      privateEventId: state.privateEvent.id,
      updatePrivateEventUserDto: updatePrivateEventUserDto,
    );

    privateEventOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          groupchat: state.groupchat,
          privateEvent: state.privateEvent,
          privateEventUsers: state.privateEventUsers,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
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
        emit(CurrentPrivateEventNormal(
          privateEvent: mergedPrivateEvent,
          privateEventUsers: state.privateEventUsers,
          groupchat: state.groupchat,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
        ));
        setPrivateEventUsers();
      },
    );
  }
}
