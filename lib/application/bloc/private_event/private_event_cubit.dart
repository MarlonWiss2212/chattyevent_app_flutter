import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'private_event_state.dart';

class PrivateEventCubit extends Cubit<PrivateEventState> {
  final PrivateEventUseCases privateEventUseCases;
  PrivateEventCubit({
    required this.privateEventUseCases,
  }) : super(PrivateEventInitial());

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
      emit(
        PrivateEventLoaded(privateEvents: newPrivateEvents),
      );
      return newPrivateEvents[foundIndex];
    } else {
      emit(
        PrivateEventLoaded(
          privateEvents: List.from(state.privateEvents)..add(privateEvent),
        ),
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
    return mergedPrivateEvents;
  }

  void delete({required String privateEventId}) {
    List<PrivateEventEntity> newPrivateEvents = state.privateEvents;
    newPrivateEvents.removeWhere(
      (element) => element.id == privateEventId,
    );
    emit(PrivateEventLoaded(privateEvents: newPrivateEvents));
  }

  Future getPrivateEventsViaApi() async {
    emit(PrivateEventLoading(privateEvents: state.privateEvents));

    final Either<Failure, List<PrivateEventEntity>> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi();

    privateEventOrFailure.fold(
      (error) => emit(
        PrivateEventError(
          privateEvents: state.privateEvents,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (privateEvents) {
        mergeOrAddMultiple(privateEvents: privateEvents);
      },
    );
  }
}
