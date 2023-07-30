import 'dart:async';

import 'package:chattyevent_app_flutter/core/enums/event/event_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_status_enum.dart';
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
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_left_user/create_event_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_user/create_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/shopping_list_item/find_shopping_list_items_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_one_event_to_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/event_user/find_one_event_user_filter.dart';
import 'package:chattyevent_app_flutter/core/response/event/event-date.response.dart';
import 'package:chattyevent_app_flutter/core/response/event/event-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_one_event_filter.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/event_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_user/update_event_user_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_event_state.dart';

class CurrentEventCubit extends Cubit<CurrentEventState> {
  final HomeEventCubit homeEventCubit;
  final ChatCubit chatCubit;
  final AuthCubit authCubit;
  final NotificationCubit notificationCubit;

  final EventUseCases eventUseCases;
  final GroupchatUseCases groupchatUseCases;
  final LocationUseCases locationUseCases;
  final ShoppingListItemUseCases shoppingListItemUseCases;
  final MessageUseCases messageUseCases;

  StreamSubscription<Either<NotificationAlert, MessageEntity>>? _subscription;

  CurrentEventCubit(
    super.initialState, {
    required this.notificationCubit,
    required this.authCubit,
    required this.locationUseCases,
    required this.homeEventCubit,
    required this.chatCubit,
    required this.groupchatUseCases,
    required this.shoppingListItemUseCases,
    required this.eventUseCases,
    required this.messageUseCases,
  });

  @override
  Future<void> close() {
    _subscription?.cancel();
    _subscription = null;
    return super.close();
  }

  Future reloadEventStandardDataViaApi() async {
    emitState(loadingGroupchat: true, loadingEvent: true);

    final Either<NotificationAlert, EventDataResponse>
        privateEventDataOrFailure = await eventUseCases.getEventDataViaApi(
      findOneEventFilter: FindOneEventFilter(
        eventId: state.event.id,
      ),
      groupchatId: state.event.groupchatTo,
    );

    privateEventDataOrFailure.fold(
      (alert) {
        emitState(loadingGroupchat: false, loadingEvent: false);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (data) {
        emitState(
          loadingGroupchat: false,
          loadingEvent: false,
          event: data.event,
          eventUsers: data.eventUsers,
          currentUserIndex: data.eventUsers.indexWhere(
            (element) => element.id == authCubit.state.currentUser.id,
          ),
          eventLeftUsers: data.eventLeftUsers,
          groupchat: data.groupchat,
        );
      },
    );
  }

  Future getEventUsersAndLeftUsersViaApi() async {
    final Either<NotificationAlert, EventUsersAndLeftUsersResponse>
        usersOrFailure = await eventUseCases.getEventUsersAndLeftUsers(
      findOneEventToFilter: FindOneEventToFilter(
        eventTo: state.event.id,
      ),
    );

    usersOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (usersAndLeftUsers) {
        emitState(
          eventUsers: usersAndLeftUsers.eventUsers,
          eventLeftUsers: usersAndLeftUsers.eventLeftUsers,
          currentUserIndex: usersAndLeftUsers.eventUsers.indexWhere(
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
            (element) => element.groupchat?.id == state.event.groupchatTo,
          )
          ?.groupchat,
    );
  }

  Future getCurrentChatViaApi() async {
    if (state.event.groupchatTo == null) {
      return;
    }
    emitState(loadingGroupchat: true);

    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await groupchatUseCases.getGroupchatViaApi(
      findOneGroupchatFilter: FindOneGroupchatFilter(
        groupchatId: state.event.groupchatTo!,
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

  Future getCurrentEvent() async {
    emitState(loadingEvent: true);

    final Either<NotificationAlert, EventEntity> eventOrFailure =
        await eventUseCases.getEventViaApi(
      findOneEventFilter: FindOneEventFilter(
        eventId: state.event.id,
      ),
    );

    eventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingEvent: false);
      },
      (event) {
        emitState(event: event, loadingEvent: false);
      },
    );
  }

  Future updateCurrentEvent({
    required UpdateEventDto updateEventDto,
  }) async {
    final Either<NotificationAlert, EventEntity> eventOrFailure =
        await eventUseCases.updatePrivateEvent(
      findOneEventFilter: FindOneEventFilter(
        eventId: state.event.id,
      ),
      updateEventDto: updateEventDto,
    );

    eventOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(loadingEvent: false);
      },
      (event) {
        emitState(
          event: event,
          loadingEvent: false,
          status: CurrentPrivateEventStateStatus.updated,
        );
      },
    );
  }

  Future deleteCurrentEventViaApi() async {
    final Either<NotificationAlert, bool> deletedOrFailure =
        await eventUseCases.deleteEventViaApi(
      findOneEventFilter: FindOneEventFilter(
        eventId: state.event.id,
      ),
    );

    deletedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (deleted) {
        if (deleted) {
          emitState(status: CurrentPrivateEventStateStatus.deleted);
          homeEventCubit.delete(eventId: state.event.id);
        }
      },
    );
  }

  Future addUserToEventViaApi({required String userId}) async {
    Either<NotificationAlert, EventUserEntity> privateEventUserOrFailure =
        await eventUseCases.addUserToEventViaApi(
      createEventUserDto: CreateEventUserDto(
        userId: userId,
        eventTo: state.event.id,
      ),
    );

    privateEventUserOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (eventUser) {
        emitState(
          eventUsers: List.from(state.eventUsers)..add(eventUser),
          eventLeftUsers: state.eventLeftUsers
              .where(
                (element) => element.id != eventUser.id,
              )
              .toList(),
        );
      },
    );
  }

  Future updateEventUser({
    EventUserStatusEnum? status,
    EventUserRoleEnum? role,
    required String userId,
  }) async {
    final Either<NotificationAlert, EventUserEntity> eventOrFailure =
        await eventUseCases.updateEventUser(
      updateEventUserDto: UpdateEventUserDto(
        status: status,
        role: role,
      ),
      findOneEventUserFilter: FindOneEventUserFilter(
        userId: userId,
        eventTo: state.event.id,
      ),
    );

    eventOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (eventUser) {
        List<EventUserEntity> eventUsers = state.eventUsers;

        final index = eventUsers.indexWhere(
          (element) => element.id == userId,
        );
        if (index == -1) {
          eventUsers.add(eventUser);
        } else {
          eventUsers[index] = eventUser;
        }

        emitState(
          eventUsers: eventUsers,
          eventLeftUsers: state.eventLeftUsers,
        );
      },
    );
  }

  Future deleteUserFromEventViaApi({required String userId}) async {
    Either<NotificationAlert, EventLeftUserEntity> eventLeftUserOrFailure =
        await eventUseCases.deleteUserFromEventViaApi(
      createEventLeftUserDto: CreateEventLeftUserDto(
        userId: userId,
        eventTo: state.event.id,
      ),
    );

    eventLeftUserOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (privateEventLeftUser) {
        emitState(
          eventUsers: state.eventUsers
              .where(
                (element) => element.id != userId,
              )
              .toList(),
          eventLeftUsers: List.from(state.eventLeftUsers)
            ..add(privateEventLeftUser),
        );
      },
    );
  }

  Future openMaps() async {
    final Either<NotificationAlert, Unit> openedOrFailure =
        await locationUseCases.openMaps(
      query:
          "${state.event.eventLocation?.address?.street} ${state.event.eventLocation?.address?.housenumber}, ${state.event.eventLocation?.address?.city}, ${state.event.eventLocation?.address?.zip}, ${state.event.eventLocation?.address?.country}",
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
      emitState(shoppingListItemStates: [
        ...state.shoppingListItemStates,
        shoppingListItemState
      ]);
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
        eventTo: state.event.id,
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
    if (state.event.groupchatTo != null) return;
    final eitherAlertOrStream = messageUseCases.getMessagesRealtimeViaApi(
      addedMessageFilter: AddedMessageFilter(
        eventTo: state.event.id,
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
    if (state.event.groupchatTo != null) return;
    emitState(loadingMessages: true);

    final Either<NotificationAlert, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      findMessagesFilter: FindMessagesFilter(
        eventTo: state.event.id,
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
          newMessages = [...state.messages, ...messages];
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
    EventEntity? event,
    List<EventUserEntity>? eventUsers,
    List<EventLeftUserEntity>? eventLeftUsers,
    List<MessageEntity>? messages,
    GroupchatEntity? groupchat,
    int? currentUserIndex,
    bool? loadingEvent,
    bool? loadingGroupchat,
    bool? loadingMessages,
    bool? loadingShoppingList,
    List<CurrentShoppingListItemState>? shoppingListItemStates,
    CurrentPrivateEventStateStatus? status,
  }) {
    final List<MessageEntity> allMessages = messages ?? state.messages;
    allMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final CurrentEventState newState = CurrentEventState(
      messages: allMessages,
      loadingMessages: loadingMessages ?? state.loadingMessages,
      currentUserIndex: currentUserIndex ?? state.currentUserIndex,
      shoppingListItemStates:
          shoppingListItemStates ?? state.shoppingListItemStates,
      loadingShoppingList: loadingShoppingList ?? state.loadingShoppingList,
      event: event ?? state.event,
      eventLeftUsers: eventLeftUsers ?? state.eventLeftUsers,
      eventUsers: eventUsers ?? state.eventUsers,
      groupchat: groupchat ?? state.groupchat,
      loadingEvent: loadingEvent ?? state.loadingEvent,
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
