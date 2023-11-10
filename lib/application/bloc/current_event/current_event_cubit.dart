import 'dart:async';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_status_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/request/request_type_enum.dart';
import 'package:chattyevent_app_flutter/core/response/event/event_add_user.response.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/request_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_messages_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/chat_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/message/find_one_message_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_one_request_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_requests_filter.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
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
  final MessageStreamCubit messageStreamCubit;

  final EventUseCases eventUseCases;
  final GroupchatUseCases groupchatUseCases;
  final LocationUseCases locationUseCases;
  final ShoppingListItemUseCases shoppingListItemUseCases;
  final MessageUseCases messageUseCases;
  final RequestUseCases requestUseCases;

  CurrentEventCubit(
    super.initialState, {
    required this.requestUseCases,
    required this.notificationCubit,
    required this.authCubit,
    required this.locationUseCases,
    required this.homeEventCubit,
    required this.chatCubit,
    required this.groupchatUseCases,
    required this.shoppingListItemUseCases,
    required this.eventUseCases,
    required this.messageUseCases,
    required this.messageStreamCubit,
  }) {
    messageStreamCubit.stream.listen((event) {
      if (event.addedMessage?.eventTo == state.event.id) {
        addMessage(message: event.addedMessage!);
      }
    });
  }

  Future reloadEventStandardDataViaApi() async {
    emitState(loadingGroupchat: true, loadingEvent: true);

    final Either<NotificationAlert, EventDataResponse>
        privateEventDataOrFailure = await eventUseCases.getEventDataViaApi(
      findOneEventFilter: FindOneEventFilter(
        eventId: state.event.id,
      ),
      groupchatId: state.event.privateEventData?.groupchatTo,
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
        );
      },
    );
  }

  void setGroupchatFromChatCubit() {
    emitState(
      groupchat: chatCubit.state.chats
          .firstWhereOrNull(
            (element) =>
                element.groupchat?.id ==
                state.event.privateEventData?.groupchatTo,
          )
          ?.groupchat,
    );
  }

  Future getCurrentChatViaApi() async {
    if (state.event.privateEventData?.groupchatTo == null) {
      return;
    }
    emitState(loadingGroupchat: true);

    final Either<NotificationAlert, GroupchatEntity> groupchatOrFailure =
        await groupchatUseCases.getGroupchatViaApi(
      findOneGroupchatFilter: FindOneGroupchatFilter(
        groupchatId: state.event.privateEventData!.groupchatTo!,
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
          chatCubit.delete(eventId: state.event.id);
        }
      },
    );
  }

  Future addUserToEventViaApi({required String userId}) async {
    Either<NotificationAlert, EventAddUserResponse> privateEventUserOrFailure =
        await eventUseCases.addUserToEventViaApi(
      createEventUserDto: CreateEventUserDto(
        userId: userId,
        eventTo: state.event.id,
      ),
    );

    privateEventUserOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (eventUserOrRequest) {
        emitState(
          eventUsers: eventUserOrRequest.eventUser != null
              ? [...state.eventUsers, eventUserOrRequest.eventUser!]
              : null,
          eventLeftUsers: eventUserOrRequest.eventUser != null
              ? state.eventLeftUsers
                  .where(
                    (element) => element.id != eventUserOrRequest.eventUser!.id,
                  )
                  .toList()
              : null,
          invitations: eventUserOrRequest.request != null
              ? [...state.invitations, eventUserOrRequest.request!]
              : state.invitations,
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
                    loading: false,
                    shoppingListItem: e,
                  ),
                )
                .toList(),
          );
        } else {
          replaceOrAddMultipleShoppingListItems(
            shoppingListItemStates: shoppingListItems
                .map(
                  (e) => CurrentShoppingListItemState(
                    shoppingListItem: e,
                    loading: false,
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

  Future loadMessages({bool reload = false}) async {
    if (state.event.privateEventData?.groupchatTo != null) return;
    emitState(loadingMessages: true);

    final Either<NotificationAlert, List<MessageEntity>> messagesOrFailure =
        await messageUseCases.getMessagesViaApi(
      findMessagesFilter: FindMessagesFilter(
        eventTo: state.event.id,
      ),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.messages.length > 50
                ? state.messages.length
                : 50
            : 50,
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

  Future<void> getInvitationsViaApi({bool reload = false}) async {
    emitState(loadingInvitations: true);

    final requestsOrFailure = await requestUseCases.getRequestsViaApi(
      findRequestsFilter: FindRequestsFilter(
        eventTo: state.event.id,
        type: RequestTypeEnum.invitation,
      ),
      limitOffsetFilter: reload
          ? LimitOffsetFilter(
              limit:
                  state.invitations.length < 20 ? 20 : state.invitations.length,
              offset: 0,
            )
          : LimitOffsetFilter(
              limit: 20,
              offset: state.invitations.length,
            ),
    );
    requestsOrFailure.fold(
      (alert) {
        emitState(loadingInvitations: false);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (requests) {
        if (reload) {
          emitState(loadingInvitations: false, invitations: requests);
        } else {
          emitState(
            loadingInvitations: false,
            invitations: [...state.invitations, ...requests],
          );
        }
      },
    );
  }

  Future<void> deleteRequestViaApiAndReloadRequests({
    required RequestEntity request,
  }) async {
    final deletedOrFailure = await requestUseCases.deleteRequestViaApi(
      findOneRequestFilter: FindOneRequestFilter(id: request.id),
    );

    await deletedOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (_) async {
        emitState(
          invitations: state.invitations
              .where((element) => element.id != request.id)
              .toList(),
        );

        //TODO: check later if i have to relaod invitations Or Join Requests
        await getInvitationsViaApi(reload: true);
      },
    );
  }

  MessageEntity addMessage({
    required MessageEntity message,
    bool replaceOrAddInOtherCubits = false,
  }) {
    emitState(
      messages: List.from(state.messages)..add(message),
      replaceOrAddInOtherCubits: replaceOrAddInOtherCubits,
    );
    return message;
  }

  Future<void> deleteMessageViaApi({required String id}) async {
    if (state.deletingMessageId != null) {
      return;
    }

    emitState(deletingMessageId: id);

    final updatedMessageOrFailure = await messageUseCases.deleteMessageViaApi(
      filter: FindOneMessage(
        id: id,
      ),
    );

    updatedMessageOrFailure.fold(
      (alert) {
        notificationCubit.newAlert(notificationAlert: alert);
        emitState(setDeletingMessageIdToNull: true);
      },
      (updatedMessage) {
        List<MessageEntity> messages = state.messages;
        final index = messages.indexWhere((element) => element.id == id);
        messages[index] = updatedMessage;
        emitState(messages: messages, setDeletingMessageIdToNull: true);
      },
    );
  }

  void emitState({
    EventEntity? event,
    List<EventUserEntity>? eventUsers,
    List<EventLeftUserEntity>? eventLeftUsers,
    List<MessageEntity>? messages,
    List<RequestEntity>? invitations,
    GroupchatEntity? groupchat,
    String? deletingMessageId,
    bool? loadingEvent,
    bool? loadingInvitations,
    bool? loadingGroupchat,
    bool? loadingMessages,
    bool? loadingShoppingList,
    List<CurrentShoppingListItemState>? shoppingListItemStates,
    CurrentPrivateEventStateStatus? status,
    bool replaceOrAddInOtherCubits = true,
    bool setDeletingMessageIdToNull = false,
  }) {
    final List<MessageEntity> allMessages = messages ?? state.messages;
    allMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final List<RequestEntity> allInvitations = invitations ?? state.invitations;
    allInvitations.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    EventEntity newEvent = event ?? state.event;
    allMessages.isNotEmpty
        ? newEvent = EventEntity.merge(
            newEntity: EventEntity(
              id: newEvent.id,
              eventDate: newEvent.eventDate,
              latestMessage: allMessages.first,
            ),
            oldEntity: newEvent,
          )
        : null;

    final newEventUsers = eventUsers ?? state.eventUsers;
    final CurrentEventState newState = CurrentEventState(
      messages: allMessages,
      invitations: allInvitations,
      deletingMessageId: setDeletingMessageIdToNull
          ? null
          : deletingMessageId ?? state.deletingMessageId,
      loadingInvitations: loadingInvitations ?? state.loadingInvitations,
      loadingMessages: loadingMessages ?? state.loadingMessages,
      currentUserIndex: newEventUsers.indexWhere(
        (element) => element.id == authCubit.state.currentUser.id,
      ),
      shoppingListItemStates:
          shoppingListItemStates ?? state.shoppingListItemStates,
      loadingShoppingList: loadingShoppingList ?? state.loadingShoppingList,
      event: newEvent,
      eventLeftUsers: eventLeftUsers ?? state.eventLeftUsers,
      eventUsers: newEventUsers,
      groupchat: groupchat ?? state.groupchat,
      loadingEvent: loadingEvent ?? state.loadingEvent,
      loadingGroupchat: loadingGroupchat ?? state.loadingGroupchat,
      status: status ?? CurrentPrivateEventStateStatus.initial,
    );

    emit(newState);
    if (replaceOrAddInOtherCubits) {
      homeEventCubit.replaceOrAdd(
        privateEventState: newState,
        onlyReplace: true,
      );
      if (state.event.privateEventData?.groupchatTo == null) {
        chatCubit.replaceOrAdd(chat: ChatEntity(event: state.event));
      }
    }
  }
}
