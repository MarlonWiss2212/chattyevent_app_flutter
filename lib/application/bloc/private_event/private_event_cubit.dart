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
    if (state is PrivateEventStateLoaded) {
      final state = this.state as PrivateEventStateLoaded;
      emit(
        PrivateEventStateLoaded(
          privateEvents: List.from(state.privateEvents)..add(privateEvent),
        ),
      );
    } else {
      emit(PrivateEventStateLoaded(privateEvents: [privateEvent]));
    }
  }

  PrivateEventEntity editPrivateEventIfExistOrAdd({
    required PrivateEventEntity privateEvent,
  }) {
    if (state is PrivateEventStateLoaded) {
      final state = this.state as PrivateEventStateLoaded;

      int foundIndex = -1;
      state.privateEvents.asMap().forEach((index, chatToFind) {
        if (chatToFind.id == privateEvent.id) {
          foundIndex = index;
        }
      });

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
          PrivateEventStateLoaded(privateEvents: newPrivateEvents),
        );
        return newPrivateEvents[foundIndex];
      } else {
        emit(
          PrivateEventStateLoaded(
            privateEvents: List.from(state.privateEvents)..add(privateEvent),
          ),
        );
      }
    } else {
      emit(
        PrivateEventStateLoaded(
          privateEvents: [privateEvent],
        ),
      );
    }
    return privateEvent;
  }

  Future getPrivateEventsViaApi() async {
    emit(PrivateEventStateLoading());

    final Either<Failure, List<PrivateEventEntity>> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApiViaApi();

    privateEventOrFailure.fold(
      (error) => emit(
        PrivateEventStateError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (privateEvents) => emit(
        PrivateEventStateLoaded(privateEvents: privateEvents),
      ),
    );
  }
}
