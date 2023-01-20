import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
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

  void editPrivateEvent({required PrivateEventEntity privateEvent}) {
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
  }

  Future getPrivateEvents() async {
    emit(PrivateEventStateLoading());

    final Either<Failure, List<PrivateEventEntity>> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi();

    privateEventOrFailure.fold(
      (error) => emit(
        PrivateEventStateError(message: mapFailureToMessage(error)),
      ),
      (privateEvents) => emit(
        PrivateEventStateLoaded(privateEvents: privateEvents),
      ),
    );
  }

  Future getOnePrivateEvent({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );

    privateEventOrFailure.fold(
      (error) {
        if (state is PrivateEventStateLoaded) {
          final state = this.state as PrivateEventStateLoaded;
          emit(
            PrivateEventStateLoaded(
              privateEvents: state.privateEvents,
              errorMessage: mapFailureToMessage(error),
            ),
          );
        } else {
          emit(
            PrivateEventStateError(
              message: mapFailureToMessage(error),
            ),
          );
        }
      },
      (privateEvent) {
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
            newPrivateEvents[foundIndex] = privateEvent;
            emit(
              PrivateEventStateLoaded(privateEvents: newPrivateEvents),
            );
          } else {
            emit(
              PrivateEventStateLoaded(
                privateEvents: List.from(state.privateEvents)
                  ..add(privateEvent),
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
      },
    );
  }
}