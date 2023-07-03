import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/find_private_events_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/private_event_usecases.dart';

part 'home_event_state.dart';

class HomeEventCubit extends Cubit<HomeEventState> {
  final PrivateEventUseCases privateEventUseCases;
  final NotificationCubit notificationCubit;

  HomeEventCubit({
    required this.privateEventUseCases,
    required this.notificationCubit,
  }) : super(const HomeEventState(
            pastPrivateEvents: [], futurePrivateEvents: []));

  CurrentPrivateEventState? replaceOrAdd({
    required CurrentPrivateEventState privateEventState,
    bool onlyReplace = false,
  }) {
    int foundIndex = state.pastPrivateEvents.indexWhere(
      (element) => element.privateEvent.id == privateEventState.privateEvent.id,
    );

    if (foundIndex != -1) {
      List<CurrentPrivateEventState> newPastPrivateEventStates =
          state.pastPrivateEvents;
      newPastPrivateEventStates[foundIndex] = privateEventState;
      emitState(pastPrivateEvents: newPastPrivateEventStates);
      return newPastPrivateEventStates[foundIndex];
    } else if (onlyReplace == false &&
        (privateEventState.privateEvent.eventDate.compareTo(DateTime.now()) ==
            -1)) {
      emitState(
        pastPrivateEvents: List.from(state.pastPrivateEvents)
          ..add(privateEventState),
      );
      return privateEventState;
    }

    int foundFutureIndex = state.futurePrivateEvents.indexWhere(
      (element) => element.privateEvent.id == privateEventState.privateEvent.id,
    );

    if (foundFutureIndex != -1) {
      List<CurrentPrivateEventState> newFuturePrivateEventStates =
          state.futurePrivateEvents;
      newFuturePrivateEventStates[foundFutureIndex] = privateEventState;
      emitState(futurePrivateEvents: newFuturePrivateEventStates);
      return newFuturePrivateEventStates[foundFutureIndex];
    } else if (onlyReplace == false) {
      emitState(
        futurePrivateEvents: List.from(state.futurePrivateEvents)
          ..add(privateEventState),
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
    List<CurrentPrivateEventState> newFuturePrivateEvents =
        state.futurePrivateEvents;
    List<CurrentPrivateEventState> newPastPrivateEvents =
        state.pastPrivateEvents;

    newFuturePrivateEvents.removeWhere(
      (element) => element.privateEvent.id == privateEventId,
    );
    newPastPrivateEvents.removeWhere(
      (element) => element.privateEvent.id == privateEventId,
    );
    emitState(
      futurePrivateEvents: newFuturePrivateEvents,
      pastPrivateEvents: newPastPrivateEvents,
    );
  }

  Future getFuturePrivateEventsViaApi({
    bool reload = false,
  }) async {
    emitState(loadingFutureEvents: true);

    final Either<NotificationAlert, List<PrivateEventEntity>>
        privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi(
      findPrivateEventsFilter: FindPrivateEventsFilter(onlyFutureEvents: true),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.futurePrivateEvents.length > 20
                ? state.futurePrivateEvents.length
                : 20
            : 20,
        offset: reload ? 0 : state.futurePrivateEvents.length,
      ),
    );

    privateEventOrFailure.fold(
      (alert) {
        emitState(loadingFutureEvents: false);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (privateEvents) {
        emitState(loadingFutureEvents: false);

        if (reload) {
          emitState(
            futurePrivateEvents: privateEvents
                .map(
                  (e) => CurrentPrivateEventState.fromPrivateEvent(
                    privateEvent: e,
                  ),
                )
                .toList(),
          );
        } else {
          replaceOrAddMultiple(
            privateEventStates: privateEvents
                .map(
                  (e) => CurrentPrivateEventState.fromPrivateEvent(
                    privateEvent: e,
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }

  Future getPastPrivateEventsViaApi({
    bool reload = false,
  }) async {
    emitState(loadingPastEvents: true);

    final Either<NotificationAlert, List<PrivateEventEntity>>
        privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi(
      findPrivateEventsFilter: FindPrivateEventsFilter(onlyPastEvents: true),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.pastPrivateEvents.length > 20
                ? state.pastPrivateEvents.length
                : 20
            : 20,
        offset: reload ? 0 : state.pastPrivateEvents.length,
      ),
    );

    privateEventOrFailure.fold(
      (alert) {
        emitState(loadingPastEvents: false);
        notificationCubit.newAlert(notificationAlert: alert);
      },
      (privateEvents) {
        emitState(loadingPastEvents: false);

        if (reload) {
          emitState(
            pastPrivateEvents: privateEvents
                .map(
                  (e) => CurrentPrivateEventState.fromPrivateEvent(
                    privateEvent: e,
                  ),
                )
                .toList(),
          );
        } else {
          replaceOrAddMultiple(
            privateEventStates: privateEvents
                .map(
                  (e) => CurrentPrivateEventState.fromPrivateEvent(
                    privateEvent: e,
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }

  emitState({
    List<CurrentPrivateEventState>? futurePrivateEvents,
    List<CurrentPrivateEventState>? pastPrivateEvents,
    bool? loadingFutureEvents,
    bool? loadingPastEvents,
  }) {
    futurePrivateEvents?.sort(
      (a, b) => a.privateEvent.eventDate.compareTo(b.privateEvent.eventDate),
    );
    pastPrivateEvents?.sort(
      (a, b) => a.privateEvent.eventDate.compareTo(b.privateEvent.eventDate),
    );
    emit(HomeEventState(
      futurePrivateEvents: futurePrivateEvents ?? state.futurePrivateEvents,
      pastPrivateEvents: pastPrivateEvents ?? state.pastPrivateEvents,
      loadingFutureEvents: loadingFutureEvents ?? state.loadingFutureEvents,
      loadingPastEvents: loadingPastEvents ?? state.loadingPastEvents,
    ));
  }
}
