import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'private_event_state.dart';

class PrivateEventCubit extends Cubit<PrivateEventState> {
  final PrivateEventUseCases privateEventUseCases;
  PrivateEventCubit({
    required this.privateEventUseCases,
  }) : super(PrivateEventInitial());

  void reset() {
    emit(PrivateEventInitial());
  }

  void addPrivateEvent({required PrivateEventEntity privateEvent}) async {
    emit(
      PrivateEventLoaded(
        privateEvents: List.from(state.privateEvents)..add(privateEvent),
      ),
    );
  }

  PrivateEventEntity editPrivateEventIfExistOrAdd({
    required PrivateEventEntity privateEvent,
  }) {
    int foundIndex = state.privateEvents.indexWhere(
      (element) => element.id == privateEvent.id,
    );

    if (foundIndex != -1) {
      List<PrivateEventEntity> newPrivateEvents = state.privateEvents;
      newPrivateEvents[foundIndex] = PrivateEventEntity(
        id: privateEvent.id,
        title: privateEvent.title ?? newPrivateEvents[foundIndex].title,
        coverImageLink: privateEvent.coverImageLink ??
            newPrivateEvents[foundIndex].coverImageLink,
        connectedGroupchat: privateEvent.connectedGroupchat ??
            newPrivateEvents[foundIndex].connectedGroupchat,
        eventDate:
            privateEvent.eventDate ?? newPrivateEvents[foundIndex].eventDate,
        eventLocation: privateEvent.eventLocation ??
            newPrivateEvents[foundIndex].eventLocation,
        usersThatWillBeThere: privateEvent.usersThatWillBeThere ??
            newPrivateEvents[foundIndex].usersThatWillBeThere,
        usersThatWillNotBeThere: privateEvent.usersThatWillNotBeThere ??
            newPrivateEvents[foundIndex].usersThatWillNotBeThere,
        createdBy:
            privateEvent.createdBy ?? newPrivateEvents[foundIndex].createdBy,
        createdAt:
            privateEvent.createdAt ?? newPrivateEvents[foundIndex].createdAt,
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

  Future getPrivateEventsViaApi() async {
    emit(PrivateEventLoading(privateEvents: state.privateEvents));

    final Either<Failure, List<PrivateEventEntity>> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApiViaApi();

    privateEventOrFailure.fold(
      (error) => emit(
        PrivateEventError(
          privateEvents: state.privateEvents,
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (privateEvents) {
        List<PrivateEventEntity> privateEventsToEmit = privateEvents;

        for (final statePrivateEvent in state.privateEvents) {
          bool savedTheUser = false;

          innerLoop:
          for (final privateEventToEmit in privateEventsToEmit) {
            if (privateEventToEmit.id == statePrivateEvent.id) {
              savedTheUser = true;
              break innerLoop;
            }
          }

          if (!savedTheUser) {
            privateEventsToEmit.add(statePrivateEvent);
          }
        }
        emit(PrivateEventLoaded(privateEvents: privateEvents));
      },
    );
  }
}
