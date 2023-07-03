import 'dart:async';

import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user/private_event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user_status_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/added_message_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/private_event_left_user/create_private_event_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/shopping_list_item/find_shopping_list_items_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/find_one_private_event_to_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/private_event_user/find_one_private_event_user_filter.dart';
import 'package:chattyevent_app_flutter/core/response/private-event/private-event-date.response.dart';
import 'package:chattyevent_app_flutter/core/response/private-event/private-events-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/find_one_private_event_filter.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/private_event_user/update_private_event_user_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_private_event_state.dart';

class CurrentPrivateEventCubit extends Cubit<CurrentPrivateEventState> {
  final HomeEventCubit homeEventCubit;
  final ChatCubit chatCubit;
  final AuthCubit authCubit;
  final NotificationCubit notificationCubit;

  final PrivateEventUseCases privateEventUseCases;
  final GroupchatUseCases groupchatUseCases;
  final LocationUseCases locationUseCases;
  final ShoppingListItemUseCases shoppingListItemUseCases;
  final MessageUseCases messageUseCases;

  StreamSubscription<Either<NotificationAlert, MessageEntity>>? _subscription;

  CurrentPrivateEventCubit(
    super.initialState, {
    required this.notificationCubit,
    required this.authCubit,
    required this.locationUseCases,
    required this.homeEventCubit,
    required this.chatCubit,
    required this.groupchatUseCases,
    required this.shoppingListItemUseCases,
    required this.privateEventUseCases,
    required this.messageUseCases,
  });

  @override
  Future<void> close() {
    _subscription?.cancel();
    _subscription = null;
    return super.close();
  }

  Future reloadPrivateEventStandardDataViaApi() async {
    emitState(loadingGroupchat: true, loadingPrivateEvent: true);

    final Either<NotificationAlert, PrivateEventDataResponse>
        privateEventDataOrFailure =
        await privateEventUseCases.getPrivateEventDataViaApi(
      findOnePrivateEventFilter: FindOnePrivateEventFilter(
        privateEventId: state.privateEvent.id,
      ),
      groupchatId: state.privateEvent.groupchatTo,
    );

    privateEventDataOrFailure.fold(
      (alert) {
        emitState(loadingGroupchat: false, loadingPrivateEvent: false);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (data) {
        emitState(
          loadingGroupchat: false,
          loadingPrivateEvent: false,
          privateEvent: data.privateEvent,
          privateEventUsers: data.privateEventUsers,
          currentUserIndex: data.privateEventUsers.indexWhere(
            (element) => element.id == authCubit.state.currentUser.id,
          ),
          privateEventLeftUsers: data.privateEventLeftUsers,
          groupchat: data.groupchat,
        );
      },
    );
  }

  Future getPrivateEventUsersAndLeftUsersViaApi() async {
    final Either<NotificationAlert, PrivateEventUsersAndLeftUsersResponse>
        usersOrFailure =
        await privateEventUseCases.getPrivateEventUsersAndLeftUsers(
      findOnePrivateEventToFilter: FindOnePrivateEventToFilter(
        privateEventTo: state.privateEvent.id,
      ),
    );

    usersOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (usersAndLeftUsers) {
        emitState(
          privateEventUsers: usersAndLeftUsers.privateEventUsers,
          privateEventLeftUsers: usersAndLeftUsers.privateEventLeftUsers,
          currentUserIndex: usersAndLeftUsers.privateEventUsers.indexWhere(
            (element) => element.id == authCubit.state.currentUser.id,
          ),
        );
      },
    );
  }

  void setGroupchatFromChatCubit() {
    emitState(
      groupchat: chatCubit.state.chats
          .firstWhereOrNull(
            (element) =>
                element.groupchat?.id == state.privateEvent.groupchatTo,
          )
          ?.groupchat,
    );
  }

  Future getCurrentChatViaApi() async {
    if (state.privateEvent.groupchatTo == null) {
      return;
    }
    emitState(loadingGroupchat: true);

    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await groupchatUseCases.getGroupchatViaApi(
      findOneGroupchatFilter: FindOneGroupchatFilter(
        groupchatId: state.privateEvent.groupchatTo!,
      ),
    );

    await groupchatOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingGroupchat: false);
      },
      (groupchat) async {
        final replacedChat = chatCubit.replaceOrAdd(
          chat: ChatEntity(groupchat: groupchat),
        );
        emitState(groupchat: replacedChat.groupchat, loadingGroupchat: false);
      },
    );
  }

  Future getCurrentPrivateEvent() async {
    emitState(loadingPrivateEvent: true);

    final Either<NotificationAlert, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      findOnePrivateEventFilter: FindOnePrivateEventFilter(
        privateEventId: state.privateEvent.id,
      ),
    );

    privateEventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingPrivateEvent: false);
      },
      (privateEvent) {
        emitState(privateEvent: privateEvent, loadingPrivateEvent: false);
      },
    );
  }

  Future updateCurrentPrivateEvent({
    required UpdatePrivateEventDto updatePrivateEventDto,
  }) async {
    final Either<NotificationAlert, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updatePrivateEvent(
      findOnePrivateEventFilter: FindOnePrivateEventFilter(
        privateEventId: state.privateEvent.id,
      ),
      updatePrivateEventDto: updatePrivateEventDto,
    );

    privateEventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingPrivateEvent: false);
      },
      (privateEvent) {
        emitState(
          privateEvent: privateEvent,
          loadingPrivateEvent: false,
          status: CurrentPrivateEventStateStatus.updated,
        );
      },
    );
  }

  Future deleteCurrentPrivateEventViaApi() async {
    final Either<NotificationAlert, bool> deletedOrFailure =
        await privateEventUseCases.deletePrivateEventViaApi(
      findOnePrivateEventFilter: FindOnePrivateEventFilter(
        privateEventId: state.privateEvent.id,
      ),
    );

    deletedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (deleted) {
        if (deleted) {
          emitState(status: CurrentPrivateEventStateStatus.deleted);
          homeEventCubit.delete(privateEventId: state.privateEvent.id);
        }
      },
    );
  }

  Future addUserToPrivateEventViaApi({required String userId}) async {
    Either<NotificationAlert, PrivateEventUserEntity>
        privateEventUserOrFailure =
        await privateEventUseCases.addUserToPrivateEventViaApi(
      createPrivateEventUserDto: CreatePrivateEventUserDto(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
    );

    privateEventUserOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (privateEventUser) {
        emitState(
          privateEventUsers: List.from(state.privateEventUsers)
            ..add(privateEventUser),
          privateEventLeftUsers: state.privateEventLeftUsers
              .where(
                (element) => element.id != privateEventUser.id,
              )
              .toList(),
        );
      },
    );
  }

  Future updatePrivateEventUser({
    PrivateEventUserStatusEnum? status,
    PrivateEventUserRoleEnum? role,
    required String userId,
  }) async {
    final Either<NotificationAlert, PrivateEventUserEntity>
        privateEventOrFailure =
        await privateEventUseCases.updatePrivateEventUser(
      updatePrivateEventUserDto: UpdatePrivateEventUserDto(
        status: status,
        role: role,
      ),
      findOnePrivateEventUserFilter: FindOnePrivateEventUserFilter(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
    );

    privateEventOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (privateEventUser) {
        List<PrivateEventUserEntity> privateEventUsers =
            state.privateEventUsers;

        final index = privateEventUsers.indexWhere(
          (element) => element.id == userId,
        );
        if (index == -1) {
          privateEventUsers.add(privateEventUser);
        } else {
          privateEventUsers[index] = privateEventUser;
        }

        emitState(
          privateEventUsers: privateEventUsers,
          privateEventLeftUsers: state.privateEventLeftUsers,
        );
      },
    );
  }

  Future deleteUserFromPrivateEventViaApi({required String userId}) async {
    Either<NotificationAlert, PrivateEventLeftUserEntity>
        privateEventLeftUserOrFailure =
        await privateEventUseCases.deleteUserFromPrivateEventViaApi(
      createPrivateEventLeftUserDto: CreatePrivateEventLeftUserDto(
        userId: userId,
        privateEventTo: state.privateEvent.id,
      ),
    );

    privateEventLeftUserOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (privateEventLeftUser) {
        emitState(
          privateEventUsers: state.privateEventUsers
              .where(
                (element) => element.id != userId,
              )
              .toList(),
          privateEventLeftUsers: List.from(state.privateEventLeftUsers)
            ..add(privateEventLeftUser),
        );
      },
    );
  }

  Future openMaps() async {
    final Either<NotificationAlert, Unit> openedOrFailure =
        await locationUseCases.openMaps(
      query:
          "${state.privateEvent.eventLocation!.street} ${state.privateEvent.eventLocation!.housenumber}, ${state.privateEvent.eventLocation!.city}, ${state.privateEvent.eventLocation!.zip}, ${state.privateEvent.eventLocation!.country}",
    );

    openedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (_) => null,
    );
  }

  // shopping list

  CurrentShoppingListItemState replaceOrAddShoppingListItem({
    required bool addIfItsNotFound,
    required CurrentShoppingListItemState shoppingListItemState,
  }) {
    int foundIndex = state.shoppingListItemStates.indexWhere(
      (element) =>
          element.shoppingListItem.id ==
          shoppingListItemState.shoppingListItem.id,
    );

    if (foundIndex != -1) {
      List<CurrentShoppingListItemState> newShoppingListItemStates =
          state.shoppingListItemStates;
      newShoppingListItemStates[foundIndex] = shoppingListItemState;
      emitState(shoppingListItemStates: newShoppingListItemStates);
      return newShoppingListItemStates[foundIndex];
    } else if (addIfItsNotFound) {
      emitState(
        shoppingListItemStates: List.from([shoppingListItemState])
          ..addAll(
            state.shoppingListItemStates,
          ),
      );
    }
    return shoppingListItemState;
  }

  List<CurrentShoppingListItemState> replaceOrAddMultipleShoppingListItems({
    required bool addIfItsNotFound,
    required List<CurrentShoppingListItemState> shoppingListItemStates,
  }) {
    List<CurrentShoppingListItemState> mergedShoppingListItemStates = [];
    for (final shoppingListItemState in shoppingListItemStates) {
      final mergedShoppingListItemState = replaceOrAddShoppingListItem(
        addIfItsNotFound: addIfItsNotFound,
        shoppingListItemState: shoppingListItemState,
      );
      mergedShoppingListItemStates.add(mergedShoppingListItemState);
    }
    return mergedShoppingListItemStates;
  }

  void deleteShoppingListItem({required String shoppingListItemId}) {
    emitState(
      shoppingListItemStates: state.shoppingListItemStates
          .where(
            (element) => element.shoppingListItem.id != shoppingListItemId,
          )
          .toList(),
    );
  }

  Future getShoppingListItemsViaApi({bool reload = false}) async {
    emitState(loadingShoppingList: true);

    final Either<NotificationAlert, List<ShoppingListItemEntity>>
        shoppingListItemsOrFailure =
        await shoppingListItemUseCases.getShoppingListItemsViaApi(
      findShoppingListItemsFilter: FindShoppingListItemsFilter(
        privateEventTo: state.privateEvent.id,
      ),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit: state.shoppingListItemStates.length < 20
                  ? 20
                  : state.shoppingListItemStates.length,
              offset: 0,
            )
          : LimitOffsetFilter(
              limit: 20,
              offset: state.shoppingListItemStates.length,
            ),
    );

    shoppingListItemsOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingShoppingList: false);
      },
      (shoppingListItems) {
        if (reload) {
          emitState(
            loadingShoppingList: false,
            shoppingListItemStates: shoppingListItems
                .map(
                  (e) => CurrentShoppingListItemState(
                    loadingShoppingListItem: false,
                    loadingBoughtAmounts: false,
                    shoppingListItem: e,
                    boughtAmounts: [],
                  ),
                )
                .toList(),
          );
        } else {
          replaceOrAddMultipleShoppingListItems(
            shoppingListItemStates: shoppingListItems
                .map(
                  (e) => CurrentShoppingListItemState(
                    loadingShoppingListItem: false,
                    loadingBoughtAmounts: false,
                    shoppingListItem: e,
                    boughtAmounts: [],
                  ),
                )
                .toList(),
            addIfItsNotFound: true,
          );
          emitState(loadingShoppingList: false);
        }
      },
    );
  }

  // messages only for private events where no groupchat is connected

  void listenToMessages() {
    if (state.privateEvent.groupchatTo != null) return;
    final eitherAlertOrStream = messageUseCases.getMessagesRealtimeViaApi(
      addedMessageFilter: AddedMessageFilter(
        privateEventTo: state.privateEvent.id,
      ),
    );

    eitherAlertOrStream.fold(
      (alert) => notificationCubit.newAlert(
        notificationAlert: NotificationAlert(
          title: "Nachrichten error",
          message:
              "Fehler beim herstellen einer Verbindung um live nachrichten zu erhalten",
        ),
      ),
      (subscription) {
        _subscription = subscription.listen(
          (event) {
            event.fold(
              (error) => notificationCubit.newAlert(
                notificationAlert: NotificationAlert(
                  title: "Nachrichten error",
                  message:
                      "Fehler beim herstellen einer Verbindung um live nachrichten zu erhalten",
                ),
              ),
              (message) => addMessage(message: message),
            );
          },
        );
      },
    );
  }

  Future loadMessages({bool reload = false}) async {
    if (state.privateEvent.groupchatTo != null) return;
    emitState(loadingMessages: true);

    final Either<NotificationAlert, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      findMessagesFilter: FindMessagesFilter(
        privateEventTo: state.privateEvent.id,
      ),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.messages.length > 20
                ? state.messages.length
                : 20
            : 20,
        offset: reload ? 0 : state.messages.length,
      ),
    );

    messagesOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingMessages: false);
      },
      (messages) {
        List<MessageEntity> newMessages = [];
        if (reload == false) {
          newMessages = List.from(state.messages)..addAll(messages);
        } else {
          newMessages = messages;
        }

        emitState(messages: newMessages, loadingMessages: false);
      },
    );
  }

  MessageEntity addMessage({required MessageEntity message}) {
    emitState(messages: List.from(state.messages)..add(message));
    return message;
  }

  void emitState({
    PrivateEventEntity? privateEvent,
    List<PrivateEventUserEntity>? privateEventUsers,
    List<PrivateEventLeftUserEntity>? privateEventLeftUsers,
    List<MessageEntity>? messages,
    GroupchatEntity? groupchat,
    int? currentUserIndex,
    bool? loadingPrivateEvent,
    bool? loadingGroupchat,
    bool? loadingMessages,
    bool? loadingShoppingList,
    List<CurrentShoppingListItemState>? shoppingListItemStates,
    CurrentPrivateEventStateStatus? status,
  }) {
    final List<MessageEntity> allMessages = messages ?? state.messages;
    allMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final CurrentPrivateEventState newState = CurrentPrivateEventState(
      messages: allMessages,
      loadingMessages: loadingMessages ?? state.loadingMessages,
      currentUserIndex: currentUserIndex ?? state.currentUserIndex,
      shoppingListItemStates:
          shoppingListItemStates ?? state.shoppingListItemStates,
      loadingShoppingList: loadingShoppingList ?? state.loadingShoppingList,
      privateEvent: privateEvent ?? state.privateEvent,
      privateEventLeftUsers:
          privateEventLeftUsers ?? state.privateEventLeftUsers,
      privateEventUsers: privateEventUsers ?? state.privateEventUsers,
      groupchat: groupchat ?? state.groupchat,
      loadingPrivateEvent: loadingPrivateEvent ?? state.loadingPrivateEvent,
      loadingGroupchat: loadingGroupchat ?? state.loadingGroupchat,
      status: status ?? CurrentPrivateEventStateStatus.initial,
    );

    emit(newState);
    homeEventCubit.replaceOrAdd(
      privateEventState: newState,
      onlyReplace: true,
    );
  }
}
