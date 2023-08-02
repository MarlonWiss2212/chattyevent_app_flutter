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
  }) : super(const HomeEventState(pastEvents: [], futureEvents: []));

  CurrentEventState? replaceOrAdd({
    required CurrentEventState privateEventState,
    bool onlyReplace = false,
  }) {
    int foundIndex = state.pastEvents.indexWhere(
      (element) => element.event.id == privateEventState.event.id,
    );

    if (foundIndex != -1) {
      List<CurrentEventState> newpastEventstates = state.pastEvents;
      newpastEventstates[foundIndex] = privateEventState;
      emitState(pastEvents: newpastEventstates);
      return newpastEventstates[foundIndex];
    } else if (onlyReplace == false &&
        (privateEventState.event.eventDate.compareTo(DateTime.now()) == -1)) {
      emitState(
        pastEvents: List.from(state.pastEvents)..add(privateEventState),
      );
      return privateEventState;
    }

    int foundFutureIndex = state.futureEvents.indexWhere(
      (element) => element.event.id == privateEventState.event.id,
    );

    if (foundFutureIndex != -1) {
      List<CurrentEventState> newfutureEventstates = state.futureEvents;
      newfutureEventstates[foundFutureIndex] = privateEventState;
      emitState(futureEvents: newfutureEventstates);
      return newfutureEventstates[foundFutureIndex];
    } else if (onlyReplace == false) {
      emitState(
        futureEvents: List.from(state.futureEvents)..add(privateEventState),
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
    List<CurrentEventState> newfutureEvents = state.futureEvents;
    List<CurrentEventState> newpastEvents = state.pastEvents;

    newfutureEvents.removeWhere(
      (element) => element.event.id == eventId,
    );
    newpastEvents.removeWhere(
      (element) => element.event.id == eventId,
    );
    emitState(
      futureEvents: newfutureEvents,
      pastEvents: newpastEvents,
    );
  }

  Future getfutureEventsViaApi({
    bool reload = false,
  }) async {
    emitState(loadingFutureEvents: true);

    final Either<NotificationAlert, List<EventEntity>> eventOrFailure =
        await eventUseCases.getEventsViaApi(
      findEventsFilter: FindEventsFilter(onlyFutureEvents: true),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.futureEvents.length > 20
                ? state.futureEvents.length
                : 20
            : 20,
        offset: reload ? 0 : state.futureEvents.length,
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
            futureEvents: privateEvents
                .map(
                  (e) => CurrentEventState.fromEvent(
                    event: e,
                  ),
                )
                .toList(),
          );
        } else {
          replaceOrAddMultiple(
            eventStates: privateEvents
                .map(
                  (e) => CurrentEventState.fromEvent(
                    event: e,
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }

  Future getpastEventsViaApi({
    bool reload = false,
  }) async {
    emitState(loadingPastEvents: true);

    final Either<NotificationAlert, List<EventEntity>> eventOrFailure =
        await eventUseCases.getEventsViaApi(
      findEventsFilter: FindEventsFilter(onlyPastEvents: true),
      limitOffsetFilter: LimitOffsetFilter(
        limit: reload
            ? state.pastEvents.length > 20
                ? state.pastEvents.length
                : 20
            : 20,
        offset: reload ? 0 : state.pastEvents.length,
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
            pastEvents: privateEvents
                .map(
                  (e) => CurrentEventState.fromEvent(
                    event: e,
                  ),
                )
                .toList(),
          );
        } else {
          replaceOrAddMultiple(
            eventStates: privateEvents
                .map(
                  (e) => CurrentEventState.fromEvent(
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
    List<CurrentEventState>? futureEvents,
    List<CurrentEventState>? pastEvents,
    bool? loadingFutureEvents,
    bool? loadingPastEvents,
  }) {
    futureEvents?.sort(
      (a, b) => a.event.eventDate.compareTo(b.event.eventDate),
    );
    pastEvents?.sort(
      (a, b) => a.event.eventDate.compareTo(b.event.eventDate),
    );
    emit(HomeEventState(
      futureEvents: futureEvents ?? state.futureEvents,
      pastEvents: pastEvents ?? state.pastEvents,
      loadingFutureEvents: loadingFutureEvents ?? state.loadingFutureEvents,
      loadingPastEvents: loadingPastEvents ?? state.loadingPastEvents,
    ));
  }
}
