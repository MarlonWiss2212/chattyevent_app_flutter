import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_events_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/event_usecases.dart';

part 'home_event_state.dart';

class HomeEventCubit extends Cubit<HomeEventState> {
  final EventUseCases eventUseCases;
  final NotificationCubit notificationCubit;

  HomeEventCubit({
    required this.eventUseCases,
    required this.notificationCubit,
  }) : super(const HomeEventState(
            pastPrivateEvents: [], futurePrivateEvents: []));

  CurrentEventState? replaceOrAdd({
    required CurrentEventState privateEventState,
    bool onlyReplace = false,
  }) {
    int foundIndex = state.pastPrivateEvents.indexWhere(
      (element) => element.event.id == privateEventState.event.id,
    );

    if (foundIndex != -1) {
      List<CurrentEventState> newPastPrivateEventStates =
          state.pastPrivateEvents;
      newPastPrivateEventStates[foundIndex] = privateEventState;
      emitState(pastPrivateEvents: newPastPrivateEventStates);
      return newPastPrivateEventStates[foundIndex];
    } else if (onlyReplace == false &&
        (privateEventState.event.eventDate.compareTo(DateTime.now()) == -1)) {
      emitState(
        pastPrivateEvents: List.from(state.pastPrivateEvents)
          ..add(privateEventState),
      );
      return privateEventState;
    }

    int foundFutureIndex = state.futurePrivateEvents.indexWhere(
      (element) => element.event.id == privateEventState.event.id,
    );

    if (foundFutureIndex != -1) {
      List<CurrentEventState> newFuturePrivateEventStates =
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

  List<CurrentEventState> replaceOrAddMultiple({
    required List<CurrentEventState> eventStates,
    bool onlyReplace = false,
  }) {
    List<CurrentEventState> mergedPrivateEventStates = [];
    for (final privateEventState in eventStates) {
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

  void delete({required String eventId}) {
    List<CurrentEventState> newFuturePrivateEvents = state.futurePrivateEvents;
    List<CurrentEventState> newPastPrivateEvents = state.pastPrivateEvents;

    newFuturePrivateEvents.removeWhere(
      (element) => element.event.id == eventId,
    );
    newPastPrivateEvents.removeWhere(
      (element) => element.event.id == eventId,
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

    final Either<NotificationAlert, List<EventEntity>> eventOrFailure =
        await eventUseCases.getEventsViaApi(
      findEventsFilter: FindEventsFilter(onlyFutureEvents: true),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.futurePrivateEvents.length > 20
                ? state.futurePrivateEvents.length
                : 20
            : 20,
        offset: reload ? 0 : state.futurePrivateEvents.length,
      ),
    );

    eventOrFailure.fold(
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
                  (e) => CurrentEventState.fromPrivateEvent(
                    event: e,
                  ),
                )
                .toList(),
          );
        } else {
          replaceOrAddMultiple(
            eventStates: privateEvents
                .map(
                  (e) => CurrentEventState.fromPrivateEvent(
                    event: e,
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

    final Either<NotificationAlert, List<EventEntity>> eventOrFailure =
        await eventUseCases.getEventsViaApi(
      findEventsFilter: FindEventsFilter(onlyPastEvents: true),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.pastPrivateEvents.length > 20
                ? state.pastPrivateEvents.length
                : 20
            : 20,
        offset: reload ? 0 : state.pastPrivateEvents.length,
      ),
    );

    eventOrFailure.fold(
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
                  (e) => CurrentEventState.fromPrivateEvent(
                    event: e,
                  ),
                )
                .toList(),
          );
        } else {
          replaceOrAddMultiple(
            eventStates: privateEvents
                .map(
                  (e) => CurrentEventState.fromPrivateEvent(
                    event: e,
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }

  emitState({
    List<CurrentEventState>? futurePrivateEvents,
    List<CurrentEventState>? pastPrivateEvents,
    bool? loadingFutureEvents,
    bool? loadingPastEvents,
  }) {
    futurePrivateEvents?.sort(
      (a, b) => a.event.eventDate.compareTo(b.event.eventDate),
    );
    pastPrivateEvents?.sort(
      (a, b) => a.event.eventDate.compareTo(b.event.eventDate),
    );
    emit(HomeEventState(
      futurePrivateEvents: futurePrivateEvents ?? state.futurePrivateEvents,
      pastPrivateEvents: pastPrivateEvents ?? state.pastPrivateEvents,
      loadingFutureEvents: loadingFutureEvents ?? state.loadingFutureEvents,
      loadingPastEvents: loadingPastEvents ?? state.loadingPastEvents,
    ));
  }
}
