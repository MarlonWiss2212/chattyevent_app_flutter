import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'private_event_state.dart';

class PrivateEventCubit extends Cubit<PrivateEventState> {
  final PrivateEventUseCases privateEventUseCases;
  PrivateEventCubit({
    required this.privateEventUseCases,
  }) : super(const PrivateEventState(privateEvents: []));

  PrivateEventEntity mergeOrAdd({required PrivateEventEntity privateEvent}) {
    int foundIndex = state.privateEvents.indexWhere(
      (element) => element.id == privateEvent.id,
    );

    if (foundIndex != -1) {
      List<PrivateEventEntity> newPrivateEvents = state.privateEvents;
      newPrivateEvents[foundIndex] = PrivateEventEntity.merge(
        newEntity: privateEvent,
        oldEntity: state.privateEvents[foundIndex],
      );

      emitState(privateEvents: newPrivateEvents);

      return newPrivateEvents[foundIndex];
    } else {
      emitState(
        privateEvents: List.from(state.privateEvents)..add(privateEvent),
      );
    }
    return privateEvent;
  }

  List<PrivateEventEntity> mergeOrAddMultiple({
    required List<PrivateEventEntity> privateEvents,
  }) {
    List<PrivateEventEntity> mergedPrivateEvents = [];
    for (final privateEvent in privateEvents) {
      // state will be changed in mergeOrAdd
      final mergedPrivateEvent = mergeOrAdd(privateEvent: privateEvent);
      mergedPrivateEvents.add(mergedPrivateEvent);
    }
    if (privateEvents.isEmpty) {
      emit(const PrivateEventState(privateEvents: []));
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

  Future getPrivateEventsViaApi() async {
    emitState(
      privateEvents: state.privateEvents,
      status: PrivateEventStateStatus.loading,
    );

    final Either<Failure, List<PrivateEventEntity>> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi();

    privateEventOrFailure.fold(
      (error) => emitState(
        privateEvents: state.privateEvents,
        status: PrivateEventStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (privateEvents) {
        mergeOrAddMultiple(privateEvents: privateEvents);
      },
    );
  }

  emitState({
    List<PrivateEventEntity>? privateEvents,
    PrivateEventStateStatus? status,
    String? loadingForPrivateEventId,
    ErrorWithTitleAndMessage? error,
  }) {
    emit(
      PrivateEventState(
        privateEvents: privateEvents ?? state.privateEvents,
        error: error,
        status: status ?? PrivateEventStateStatus.initial,
      ),
    );
  }
}
