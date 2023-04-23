import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
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

  PrivateEventEntity replaceOrAdd({required PrivateEventEntity privateEvent}) {
    int foundIndex = state.privateEvents.indexWhere(
      (element) => element.id == privateEvent.id,
    );

    if (foundIndex != -1) {
      List<PrivateEventEntity> newFuturePrivateEvents = state.privateEvents;
      newFuturePrivateEvents[foundIndex] = PrivateEventEntity.merge(
        newEntity: privateEvent,
        oldEntity: state.privateEvents[foundIndex],
      );
      emitState(privateEvents: newFuturePrivateEvents);
      return newFuturePrivateEvents[foundIndex];
    } else {
      emitState(
        privateEvents: List.from(state.privateEvents)..add(privateEvent),
      );
    }
    return privateEvent;
  }

  List<PrivateEventEntity> replaceOrAddMultiple({
    required List<PrivateEventEntity> privateEvents,
  }) {
    List<PrivateEventEntity> mergedPrivateEvents = [];
    for (final privateEvent in privateEvents) {
      final mergedPrivateEvent = replaceOrAdd(privateEvent: privateEvent);
      mergedPrivateEvents.add(mergedPrivateEvent);
    }
    return mergedPrivateEvents;
  }

  void delete({required String privateEventId}) {
    List<PrivateEventEntity> newPrivateEvents = state.privateEvents;

    newPrivateEvents.removeWhere(
      (element) => element.id == privateEventId,
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
        replaceOrAddMultiple(privateEvents: privateEvents);
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
        replaceOrAddMultiple(privateEvents: privateEvents);
      },
    );
  }

  emitState({
    List<PrivateEventEntity>? privateEvents,
    HomeEventStateStatus? status,
  }) {
    privateEvents?.sort((a, b) => a.eventDate.compareTo(b.eventDate));

    final currentDate = DateTime.now();

    final futureEventsLength = privateEvents
        ?.where((element) => element.eventDate.compareTo(currentDate) >= 0)
        .length;

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
