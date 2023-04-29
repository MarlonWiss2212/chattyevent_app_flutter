import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/core/filter/get_private_events_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'home_event_state.dart';

class HomeEventCubit extends Cubit<HomeEventState> {
  final PrivateEventUseCases privateEventUseCases;
  final NotificationCubit notificationCubit;

  HomeEventCubit({
    required this.privateEventUseCases,
    required this.notificationCubit,
  }) : super(const HomeEventState(
          privateEvents: [],
          futureOffset: 0,
          pastOffset: 0,
        ));

  CurrentPrivateEventState? replaceOrAdd({
    required CurrentPrivateEventState privateEventState,
    bool onlyReplace = false,
  }) {
    int foundIndex = state.privateEvents.indexWhere(
      (element) => element.privateEvent.id == privateEventState.privateEvent.id,
    );

    if (foundIndex != -1) {
      List<CurrentPrivateEventState> newPrivateEventStates =
          state.privateEvents;
      newPrivateEventStates[foundIndex] = privateEventState;
      emitState(privateEvents: newPrivateEventStates);
      return newPrivateEventStates[foundIndex];
    } else if (onlyReplace == false) {
      emitState(
        privateEvents: List.from(state.privateEvents)..add(privateEventState),
      );
      return privateEventState;
    }
    return null;
  }

  List<CurrentPrivateEventState> replaceOrAddMultiple({
    required List<CurrentPrivateEventState> privateEventStates,
    bool onlyReplace = false,
  }) {
    List<CurrentPrivateEventState> mergedPrivateEventStates = [];
    for (final privateEventState in privateEventStates) {
      final mergedPrivateEvent = replaceOrAdd(
        privateEventState: privateEventState,
        onlyReplace: onlyReplace,
      );
      mergedPrivateEvent != null
          ? mergedPrivateEventStates.add(mergedPrivateEvent)
          : null;
    }
    return mergedPrivateEventStates;
  }

  void delete({required String privateEventId}) {
    List<CurrentPrivateEventState> newPrivateEvents = state.privateEvents;

    newPrivateEvents.removeWhere(
      (element) => element.privateEvent.id == privateEventId,
    );
    emitState(privateEvents: newPrivateEvents);
  }

  Future getFuturePrivateEventsViaApi({
    bool reload = false,
  }) async {
    emitState(status: HomeEventStateStatus.loading);

    final futureEventsLength = reload ? state.getFutureEvents().length : null;

    final Either<NotificationAlert, List<PrivateEventEntity>>
        privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi(
      getPrivateEventsFilter: GetPrivateEventsFilter(onlyFutureEvents: true),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? futureEventsLength! > 20
                ? futureEventsLength
                : 20
            : 20,
        offset: reload ? 0 : state.futureOffset,
      ),
    );

    privateEventOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (privateEvents) {
        emitState(status: HomeEventStateStatus.success);
        replaceOrAddMultiple(
          privateEventStates: privateEvents
              .map(
                (e) => CurrentPrivateEventState(
                  privateEvent: e,
                  loadingGroupchat: false,
                  loadingPrivateEvent: false,
                  loadingShoppingList: false,
                  currentUserIndex: -1,
                  privateEventUsers: [],
                  privateEventLeftUsers: [],
                  shoppingListItemStates: [],
                ),
              )
              .toList(),
        );
      },
    );
  }

  Future getPastPrivateEventsViaApi({
    bool reload = false,
  }) async {
    emitState(status: HomeEventStateStatus.loading);

    final pastEventsLength = reload ? state.getPastEvents().length : null;

    final Either<NotificationAlert, List<PrivateEventEntity>>
        privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi(
      getPrivateEventsFilter: GetPrivateEventsFilter(onlyPastEvents: true),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? pastEventsLength! > 20
                ? pastEventsLength
                : 20
            : 20,
        offset: reload ? 0 : state.futureOffset,
      ),
    );

    privateEventOrFailure.fold(
      (alert) => notificationCubit.newAlert(notificationAlert: alert),
      (privateEvents) {
        emitState(status: HomeEventStateStatus.success);
        replaceOrAddMultiple(
          privateEventStates: privateEvents
              .map(
                (e) => CurrentPrivateEventState(
                  privateEvent: e,
                  loadingGroupchat: false,
                  loadingPrivateEvent: false,
                  loadingShoppingList: false,
                  currentUserIndex: -1,
                  privateEventUsers: [],
                  privateEventLeftUsers: [],
                  shoppingListItemStates: [],
                ),
              )
              .toList(),
        );
      },
    );
  }

  emitState({
    List<CurrentPrivateEventState>? privateEvents,
    HomeEventStateStatus? status,
  }) {
    privateEvents?.sort(
      (a, b) => a.privateEvent.eventDate.compareTo(b.privateEvent.eventDate),
    );

    final currentDate = DateTime.now();

    final futureEventsLength = privateEvents?.where((element) {
      return element.privateEvent.eventDate.compareTo(currentDate) >= 0;
    }).length;

    emit(HomeEventState(
      privateEvents: privateEvents ?? state.privateEvents,
      pastOffset: privateEvents != null
          ? (privateEvents.length - futureEventsLength!)
          : state.pastOffset,
      futureOffset:
          privateEvents != null ? futureEventsLength! : state.futureOffset,
      status: status ?? HomeEventStateStatus.initial,
    ));
  }
}
