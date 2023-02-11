import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_shopping_list_items_filter.dart';
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

  Future getPrivateEventAndGroupchatFromApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
    GetOneGroupchatFilter? getOneGroupchatFilter,
  }) async {
    await getOnePrivateEvent(
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
    List<PrivateEventUser> usersToEmit = [];

    if (state.privateEvent.usersThatWillBeThere != null) {
      for (final userId in state.privateEvent.usersThatWillBeThere!) {
        final foundUser = userCubit.state.users.firstWhere(
          (element) => element.id == userId,
          orElse: () => UserEntity(id: ""),
        );
        usersToEmit.add(
          PrivateEventUser.fromUserEntity(user: foundUser, accapted: true),
        );
      }
    }

    if (state.privateEvent.usersThatWillNotBeThere != null) {
      for (final userId in state.privateEvent.usersThatWillNotBeThere!) {
        final foundUser = userCubit.state.users.firstWhere(
          (element) => element.id == userId,
          orElse: () => UserEntity(id: ""),
        );
        usersToEmit.add(
          PrivateEventUser.fromUserEntity(user: foundUser, declined: true),
        );
      }
    }

    if (state.groupchat.users != null) {
      for (final groupchatUser in state.groupchat.users!) {
        final foundIndex = usersToEmit.indexWhere(
          (element) => element.id == groupchatUser.userId,
        );
        if (foundIndex != -1) {
          usersToEmit[foundIndex] = PrivateEventUser.fromPrivateEventUser(
            privateEventUser: usersToEmit[foundIndex],
            admin: groupchatUser.admin,
          );
        } else {
          final foundUser = userCubit.state.users.firstWhere(
            (element) => element.id == groupchatUser.userId,
            orElse: () => UserEntity(id: ""),
          );
          usersToEmit.add(
            PrivateEventUser.fromUserEntity(user: foundUser, invited: true),
          );
        }
      }
    }

    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      privateEvent: state.privateEvent,
      privateEventUsers: usersToEmit,
      shoppingList: state.shoppingList,
      loadingGroupchat: state.loadingGroupchat,
      loadingPrivateEvent: state.loadingPrivateEvent,
      loadingShoppingList: state.loadingShoppingList,
    ));
  }

  Future getShoppingListViaApi({
    required GetShoppingListItemsFilter getShoppingListItemsFilter,
  }) async {
    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      shoppingList: state.shoppingList,
      loadingGroupchat: state.loadingGroupchat,
      loadingPrivateEvent: state.loadingPrivateEvent,
      loadingShoppingList: true,
    ));

    final Either<Failure, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter: getShoppingListItemsFilter,
    );

    shoppingListItemsOrFailure.fold(
      (error) => emit(CurrentPrivateEventError(
        groupchat: state.groupchat,
        shoppingList: state.shoppingList,
        privateEvent: state.privateEvent,
        privateEventUsers: state.privateEventUsers,
        message: mapFailureToMessage(error),
        loadingGroupchat: state.loadingGroupchat,
        loadingPrivateEvent: state.loadingPrivateEvent,
        loadingShoppingList: false,
        title: "Fehler Shopping List",
      )),
      (shoppingListItems) {
        shoppingListCubit.mergeOrAddMultiple(
          shoppingListItems: shoppingListItems,
        );
        reloadShoppingListFromShoppingListCubit(
          loadingShoppingListFromApi: false,
        );
      },
    );
  }

  Future updateShoppingListItemViaApi({
    required UpdateShoppingListItemDto updateShoppingListItemDto,
    required String shoppingListItemId,
  }) async {
    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      shoppingList: state.shoppingList,
      loadingGroupchat: state.loadingGroupchat,
      loadingPrivateEvent: state.loadingPrivateEvent,
      loadingShoppingList: true,
    ));
    final Either<Failure, ShoppingListItemEntity> shoppingListItemOrFailure =
        await shoppingListItemUseCases.updateShoppingListItemsViaApi(
      updateShoppingListItemDto: updateShoppingListItemDto,
      shoppingListItemId: shoppingListItemId,
    );

    shoppingListItemOrFailure.fold(
      (error) => emit(CurrentPrivateEventError(
        privateEventUsers: state.privateEventUsers,
        privateEvent: state.privateEvent,
        message: mapFailureToMessage(error),
        title: "Update Failure",
        groupchat: state.groupchat,
        shoppingList: state.shoppingList,
        loadingGroupchat: state.loadingGroupchat,
        loadingPrivateEvent: state.loadingPrivateEvent,
        loadingShoppingList: false,
      )),
      (shoppingListItem) {
        shoppingListCubit.mergeOrAdd(shoppingListItem: shoppingListItem);
        reloadShoppingListFromShoppingListCubit(
          loadingShoppingListFromApi: false,
        );
      },
    );
  }

  void reloadShoppingListFromShoppingListCubit({
    bool? loadingShoppingListFromApi,
  }) {
    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      shoppingList: shoppingListCubit.state.shoppingList
          .where((element) => element.privateEventId == state.privateEvent.id)
          .toList(),
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      loadingGroupchat: state.loadingGroupchat,
      loadingPrivateEvent: state.loadingPrivateEvent,
      loadingShoppingList:
          loadingShoppingListFromApi ?? state.loadingShoppingList,
    ));
  }

  Future getOnePrivateEvent({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      shoppingList: state.shoppingList,
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      loadingPrivateEvent: true,
      loadingGroupchat: state.loadingGroupchat,
      loadingShoppingList: state.loadingShoppingList,
    ));

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );

    privateEventOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          groupchat: state.groupchat,
          shoppingList: state.shoppingList,
          privateEvent: state.privateEvent,
          privateEventUsers: state.privateEventUsers,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
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
          shoppingList: state.shoppingList,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
        ));
        setPrivateEventUsers();
      },
    );
  }

  Future getCurrentChatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      shoppingList: state.shoppingList,
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      loadingPrivateEvent: state.loadingPrivateEvent,
      loadingGroupchat: true,
      loadingShoppingList: state.loadingShoppingList,
    ));
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          groupchat: state.groupchat,
          shoppingList: state.shoppingList,
          privateEvent: state.privateEvent,
          privateEventUsers: state.privateEventUsers,
          loadingPrivateEvent: state.loadingPrivateEvent,
          loadingGroupchat: false,
          loadingShoppingList: state.loadingShoppingList,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (groupchat) {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(CurrentPrivateEventNormal(
          groupchat: mergedChat,
          shoppingList: state.shoppingList,
          privateEvent: state.privateEvent,
          privateEventUsers: state.privateEventUsers,
          loadingPrivateEvent: state.loadingPrivateEvent,
          loadingGroupchat: false,
          loadingShoppingList: state.loadingShoppingList,
        ));
        setPrivateEventUsers();
      },
    );
  }

  void setCurrentPrivateEventData({
    PrivateEventEntity? privateEvent,
    GroupchatEntity? groupchat,
    List<ShoppingListItemEntity>? shoppingList,
    List<PrivateEventUser>? privateEventUsers,
  }) {
    emit(CurrentPrivateEventNormal(
      privateEvent: privateEvent ?? state.privateEvent,
      privateEventUsers: privateEventUsers ?? state.privateEventUsers,
      groupchat: groupchat ?? state.groupchat,
      shoppingList: shoppingList ?? state.shoppingList,
      loadingPrivateEvent: state.loadingPrivateEvent,
      loadingGroupchat: state.loadingGroupchat,
      loadingShoppingList: state.loadingShoppingList,
    ));
    setPrivateEventUsers();
  }

  Future updateMeInPrivateEventWillBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventNormal(
      privateEvent: state.privateEvent,
      privateEventUsers: state.privateEventUsers,
      groupchat: state.groupchat,
      shoppingList: state.shoppingList,
      loadingPrivateEvent: true,
      loadingGroupchat: state.loadingGroupchat,
      loadingShoppingList: state.loadingShoppingList,
    ));

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updateMeInPrivateEventWillBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          groupchat: state.groupchat,
          shoppingList: state.shoppingList,
          privateEvent: state.privateEvent,
          privateEventUsers: state.privateEventUsers,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (privateEvent) {
        final mergedPrivateEvent = privateEventCubit.mergeOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventNormal(
          privateEvent: mergedPrivateEvent,
          shoppingList: state.shoppingList,
          privateEventUsers: state.privateEventUsers,
          groupchat: state.groupchat,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
        ));
        setPrivateEventUsers();
      },
    );
  }

  Future updateMeInPrivateEventWillNotBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventNormal(
      privateEvent: state.privateEvent,
      groupchat: state.groupchat,
      shoppingList: state.shoppingList,
      privateEventUsers: state.privateEventUsers,
      loadingGroupchat: state.loadingGroupchat,
      loadingShoppingList: state.loadingShoppingList,
      loadingPrivateEvent: true,
    ));

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updateMeInPrivateEventWillNotBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          groupchat: state.groupchat,
          shoppingList: state.shoppingList,
          privateEventUsers: state.privateEventUsers,
          privateEvent: state.privateEvent,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
          loadingPrivateEvent: false,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (privateEvent) {
        final mergedPrivateEvent = privateEventCubit.mergeOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventNormal(
          privateEvent: mergedPrivateEvent,
          privateEventUsers: state.privateEventUsers,
          shoppingList: state.shoppingList,
          groupchat: state.groupchat,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
          loadingPrivateEvent: false,
        ));
        setPrivateEventUsers();
      },
    );
  }

  Future updateMeInPrivateEventNoInformationOnWillBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventNormal(
      privateEvent: state.privateEvent,
      groupchat: state.groupchat,
      privateEventUsers: state.privateEventUsers,
      shoppingList: state.shoppingList,
      loadingGroupchat: state.loadingGroupchat,
      loadingShoppingList: state.loadingShoppingList,
      loadingPrivateEvent: true,
    ));

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases
            .updateMeInPrivateEventNoInformationOnWillBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          groupchat: state.groupchat,
          shoppingList: state.shoppingList,
          privateEventUsers: state.privateEventUsers,
          privateEvent: state.privateEvent,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
          loadingPrivateEvent: false,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (privateEvent) {
        final mergedPrivateEvent = privateEventCubit.mergeOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventNormal(
          privateEvent: mergedPrivateEvent,
          privateEventUsers: state.privateEventUsers,
          shoppingList: state.shoppingList,
          groupchat: state.groupchat,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
          loadingPrivateEvent: false,
        ));
        setPrivateEventUsers();
      },
    );
  }
}
