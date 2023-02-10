import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
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

  final PrivateEventUseCases privateEventUseCases;
  final ChatUseCases chatUseCases;
  final ShoppingListItemUseCases shoppingListItemUseCases;

  CurrentPrivateEventCubit(
    super.initialState, {
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

  Future getShoppingListViaApi({
    required GetShoppingListItemsFilter getShoppingListItemsFilter,
  }) async {
    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      privateEvent: state.privateEvent,
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

  // shopping list add update delte functions for this cubit
  void reloadShoppingListFromShoppingListCubit({
    bool? loadingShoppingListFromApi,
  }) {
    emit(CurrentPrivateEventNormal(
      groupchat: state.groupchat,
      shoppingList: shoppingListCubit.state.shoppingList
          .where((element) => element.privateEvent == state.privateEvent.id)
          .toList(),
      privateEvent: state.privateEvent,
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
          groupchat: state.groupchat,
          shoppingList: state.shoppingList,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
        ));
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
          loadingPrivateEvent: state.loadingPrivateEvent,
          loadingGroupchat: false,
          loadingShoppingList: state.loadingShoppingList,
        ));
      },
    );
  }

  void setCurrentPrivateEventData({
    required PrivateEventEntity? privateEvent,
    required GroupchatEntity? groupchat,
    required List<ShoppingListItemEntity>? shoppingList,
  }) {
    emit(CurrentPrivateEventNormal(
      privateEvent: privateEvent ?? state.privateEvent,
      groupchat: groupchat ?? state.groupchat,
      shoppingList: shoppingList ?? state.shoppingList,
      loadingPrivateEvent: state.loadingPrivateEvent,
      loadingGroupchat: state.loadingGroupchat,
      loadingShoppingList: state.loadingShoppingList,
    ));
  }

  Future updateMeInPrivateEventWillBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventNormal(
      privateEvent: state.privateEvent,
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
          groupchat: state.groupchat,
          loadingPrivateEvent: false,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
        ));
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
          shoppingList: state.shoppingList,
          groupchat: state.groupchat,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
          loadingPrivateEvent: false,
        ));
      },
    );
  }

  Future updateMeInPrivateEventNoInformationOnWillBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventNormal(
      privateEvent: state.privateEvent,
      groupchat: state.groupchat,
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
          shoppingList: state.shoppingList,
          groupchat: state.groupchat,
          loadingGroupchat: state.loadingGroupchat,
          loadingShoppingList: state.loadingShoppingList,
          loadingPrivateEvent: false,
        ));
      },
    );
  }
}
