import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/create_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/private_event_user/get_one_private_event_user_filter.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/location_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';

part 'current_private_event_state.dart';

class CurrentPrivateEventCubit extends Cubit<CurrentPrivateEventState> {
  final PrivateEventCubit privateEventCubit;
  final ChatCubit chatCubit;
  final UserCubit userCubit;

  final PrivateEventUseCases privateEventUseCases;
  final ChatUseCases chatUseCases;
  final LocationUseCases locationUseCases;
  final ShoppingListItemUseCases shoppingListItemUseCases;

  CurrentPrivateEventCubit(
    super.initialState, {
    required this.userCubit,
    required this.locationUseCases,
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

  Future getPrivateEventAndGroupchatFromApi() async {
    await Future.wait([
      getCurrentPrivateEvent(),
      getCurrentChatViaApi(),
    ]);
  }

  void setPrivateEventUsers() {
    List<UserWithPrivateEventUserData> usersToEmit = [];

    if (state.privateEvent.users != null) {
      for (final privateEventUser in state.privateEvent.users!) {
        final foundUser = userCubit.state.users.firstWhere(
          (element) => element.id == privateEventUser.userId,
          orElse: () => UserEntity(
            id: privateEventUser.userId ?? "",
            authId: "",
          ),
        );
        GroupchatUserEntity? foundGroupchatUser;
        if (state.groupchat != null) {
          foundGroupchatUser = state.groupchat!.users?.firstWhere(
            (element) => element.userId == privateEventUser.userId,
            orElse: () => GroupchatUserEntity(id: ""),
          );
        }

        usersToEmit.add(UserWithPrivateEventUserData(
          user: foundUser,
          groupchatUser: foundGroupchatUser,
          privateEventUser: privateEventUser,
        ));
      }
    }

    emitState(privateEventUsers: usersToEmit);
  }

  void setCurrentChatFromChatCubit() {
    emitState(
      groupchat: chatCubit.state.chats.firstWhereOrNull(
        (element) => element.id == state.privateEvent.groupchatTo,
      ),
    );
  }

  void setPrivateEventFromPrivateEventCubit() {
    emitState(
      privateEvent: privateEventCubit.state.privateEvents.firstWhereOrNull(
        (element) => element.id == state.privateEvent.id,
      ),
    );
  }

  Future getCurrentChatViaApi() async {
    if (state.privateEvent.groupchatTo == null) {
      return;
    }
    emitState(loadingGroupchat: true);

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: GetOneGroupchatFilter(
        id: state.privateEvent.groupchatTo!,
      ),
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
        final replacedChat = chatCubit.replaceOrAdd(
          groupchat: groupchat,
          setMessagesFromOldEntity: true,
          setLeftUsersFromOldEntity: false,
          setUsersFromOldEntity: false,
        );
        emitState(groupchat: replacedChat, loadingGroupchat: false);
        setPrivateEventUsers();
      },
    );
  }

  Future getCurrentPrivateEvent() async {
    emitState(loadingPrivateEvent: true);

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: GetOnePrivateEventFilter(
        id: state.privateEvent.id,
      ),
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
        final replacedPrivateEvent = privateEventCubit.replaceOrAdd(
          privateEvent: privateEvent,
          setUsersFromOldEntity: false,
        );
        emitState(
          privateEvent: replacedPrivateEvent,
          loadingPrivateEvent: false,
        );
        setPrivateEventUsers();
      },
    );
  }

  Future createPrivateEventUser({required String userId}) async {
    emitState(loadingPrivateEvent: true);

    Either<Failure, PrivateEventUserEntity> privateEventUserOrFailure =
        await privateEventUseCases.createPrivateEventUserViaApi(
      createPrivateEventUserDto: CreatePrivateEventUserDto(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
    );

    privateEventUserOrFailure.fold(
      (error) => emitState(
        error: ErrorWithTitleAndMessage(
          title: "Create Event User Failure",
          message: mapFailureToMessage(error),
        ),
        loadingPrivateEvent: false,
      ),
      (privateEventUser) {
        final replacedPrivateEvent = privateEventCubit.replaceOrAdd(
          privateEvent: PrivateEventEntity(
            id: state.privateEvent.id,
            users: [privateEventUser],
          ),
          setUsersFromOldEntity: true,
        );
        emitState(
          loadingPrivateEvent: false,
          privateEvent: replacedPrivateEvent,
        );
        setPrivateEventUsers();
      },
    );
  }

  Future updatePrivateEventUser({
    String? status,
    bool? organizer,
    required String userId,
  }) async {
    emitState(loadingPrivateEvent: true);

    final Either<Failure, PrivateEventUserEntity> privateEventOrFailure =
        await privateEventUseCases.updatePrivateEventUser(
      updatePrivateEventUserDto: UpdatePrivateEventUserDto(
        status: status,
        organizer: organizer,
      ),
      getOnePrivateEventFilter: GetOnePrivateEventUserFilter(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
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
        final replacedPrivateEvent = privateEventCubit.replaceOrAdd(
          privateEvent: PrivateEventEntity(
            id: state.privateEvent.id,
            users: [privateEventUser],
          ),
          setUsersFromOldEntity: true,
        );
        emitState(
          loadingPrivateEvent: false,
          privateEvent: replacedPrivateEvent,
        );
        setPrivateEventUsers();
      },
    );
  }

  Future openMaps() async {
    final Either<String, Unit> openedOrFailure =
        await locationUseCases.openMaps(
      query:
          "${state.privateEvent.eventLocation!.street} ${state.privateEvent.eventLocation!.housenumber}, ${state.privateEvent.eventLocation!.city}, ${state.privateEvent.eventLocation!.zip}, ${state.privateEvent.eventLocation!.country}",
    );

    openedOrFailure.fold(
      (errorMsg) => emitState(
        error: ErrorWithTitleAndMessage(
          title: "Google Maps Fehler",
          message: errorMsg,
        ),
        status: CurrentPrivateEventStateStatus.error,
      ),
      (_) => null,
    );
  }

  // shopping list

  ShoppingListItemEntity replaceOrAddShoppingListItem({
    required bool addIfItsNotFound,
    required ShoppingListItemEntity shoppingListItem,
  }) {
    int foundIndex = state.shoppingListItems.indexWhere(
      (element) => element.id == shoppingListItem.id,
    );

    if (foundIndex != -1) {
      List<ShoppingListItemEntity> newShoppingListItems =
          state.shoppingListItems;
      newShoppingListItems[foundIndex] = ShoppingListItemEntity.merge(
        newEntity: shoppingListItem,
        oldEntity: state.shoppingListItems[foundIndex],
      );
      emitState(shoppingListItems: newShoppingListItems);
      return newShoppingListItems[foundIndex];
    } else if (addIfItsNotFound) {
      emitState(
        shoppingListItems: List.from(state.shoppingListItems)
          ..add(
            shoppingListItem,
          ),
      );
    }
    return shoppingListItem;
  }

  List<ShoppingListItemEntity> replaceOrAddMultipleShoppingListItems({
    required bool addIfItsNotFound,
    required List<ShoppingListItemEntity> shoppingListItems,
  }) {
    List<ShoppingListItemEntity> mergedShoppingList = [];
    for (final shoppingListItem in shoppingListItems) {
      final mergedShoppingListItem = replaceOrAddShoppingListItem(
        addIfItsNotFound: addIfItsNotFound,
        shoppingListItem: shoppingListItem,
      );
      mergedShoppingList.add(mergedShoppingListItem);
    }
    return mergedShoppingList;
  }

  void deleteShoppingListItem({required String shoppingListItemId}) {
    emitState(
      shoppingListItems: state.shoppingListItems
          .where(
            (element) => element.id != shoppingListItemId,
          )
          .toList(),
    );
  }

  Future getShoppingListItemsViaApi({
    bool reload = false,
  }) async {
    emitState(loadingShoppingList: true);

    final Either<Failure, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      getShoppingListItemsFilter:
          GetShoppingListItemsFilter(privateEventId: state.privateEvent.id),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit: state.shoppingListItems.length > 10
                  ? 10
                  : state.shoppingListItems.length,
              offset: 0,
            )
          : LimitOffsetFilter(
              limit: 20,
              offset: state.shoppingListItems.length,
            ),
    );

    shoppingListItemsOrFailure.fold(
      (error) => emitState(
        loadingShoppingList: false,
        error: ErrorWithTitleAndMessage(
          message: mapFailureToMessage(error),
          title: "Lade Fehler",
        ),
      ),
      (shoppingListItems) {
        replaceOrAddMultipleShoppingListItems(
          shoppingListItems: shoppingListItems,
          addIfItsNotFound: true,
        );
      },
    );
  }

  //

  void emitState({
    PrivateEventEntity? privateEvent,
    List<UserWithPrivateEventUserData>? privateEventUsers,
    GroupchatEntity? groupchat,
    bool? loadingPrivateEvent,
    bool? loadingGroupchat,
    bool? loadingShoppingList,
    List<ShoppingListItemEntity>? shoppingListItems,
    CurrentPrivateEventStateStatus? status,
    ErrorWithTitleAndMessage? error,
  }) {
    emit(CurrentPrivateEventState(
      shoppingListItems: shoppingListItems ?? state.shoppingListItems,
      loadingShoppingList: loadingShoppingList ?? state.loadingShoppingList,
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
