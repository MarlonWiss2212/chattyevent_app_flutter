import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/dto/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'private_event_event.dart';
part 'private_event_state.dart';

class PrivateEventBloc extends Bloc<PrivateEventEvent, PrivateEventState> {
  final PrivateEventUseCases privateEventUseCases;

  PrivateEventBloc({required this.privateEventUseCases})
      : super(PrivateEventInitial()) {
    on<PrivateEventEvent>((event, emit) {});

    on<PrivateEventInitialEvent>((event, emit) {
      emit(PrivateEventInitial());
    });

    on<PrivateEventCreateEvent>((event, emit) async {
      final Either<Failure, PrivateEventEntity> privateEventOrFailure =
          await privateEventUseCases
              .createPrivateEventViaApi(event.createPrivateEventDto);

      privateEventOrFailure.fold(
        (error) {
          if (state is PrivateEventStateLoaded) {
            final state = this.state as PrivateEventStateLoaded;
            emit(PrivateEventStateLoaded(
              privateEvents: state.privateEvents,
              errorMessage: mapFailureToMessage(error),
            ));
          } else {
            emit(PrivateEventStateError(message: mapFailureToMessage(error)));
          }
        },
        (privateEvent) {
          if (state is PrivateEventStateLoaded) {
            final state = this.state as PrivateEventStateLoaded;
            emit(PrivateEventStateLoaded(
              privateEvents: List.from(state.privateEvents)..add(privateEvent),
              createdPrivateEventId: privateEvent.id,
            ));
          } else {
            emit(
              PrivateEventStateLoaded(
                privateEvents: [privateEvent],
                createdPrivateEventId: privateEvent.id,
              ),
            );
          }
        },
      );
    });

    on<GetOnePrivateEventEvent>((event, emit) async {
      final Either<Failure, PrivateEventEntity> privateEventOrFailure =
          await privateEventUseCases.getPrivateEventViaApi(
        getOnePrivateEventFilter: event.getOnePrivateEventEvent,
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
    });

    on<GetPrivateEventsEvent>((event, emit) async {
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
    });

    on<UpdateMeInPrivateEventWillBeThereEvent>((event, emit) async {
      final Either<Failure, PrivateEventEntity> privateEventOrFailure =
          await privateEventUseCases.updateMeInPrivateEventWillBeThere(
        privateEventId: event.privateEventId,
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
              newPrivateEvents[foundIndex] = PrivateEventEntity(
                id: privateEvent.id,
                title: newPrivateEvents[foundIndex].title,
                coverImageLink: newPrivateEvents[foundIndex].coverImageLink,
                connectedGroupchat:
                    newPrivateEvents[foundIndex].connectedGroupchat,
                eventDate: newPrivateEvents[foundIndex].eventDate,
                usersThatWillBeThere: privateEvent.usersThatWillBeThere,
                usersThatWillNotBeThere: privateEvent.usersThatWillNotBeThere,
                createdBy: newPrivateEvents[foundIndex].createdBy,
                createdAt: newPrivateEvents[foundIndex].createdAt,
              );

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
    });

    on<UpdateMeInPrivateEventWillNotBeThereEvent>((event, emit) async {
      final Either<Failure, PrivateEventEntity> privateEventOrFailure =
          await privateEventUseCases.updateMeInPrivateEventWillNotBeThere(
        privateEventId: event.privateEventId,
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
              newPrivateEvents[foundIndex] = PrivateEventEntity(
                id: privateEvent.id,
                title: newPrivateEvents[foundIndex].title,
                coverImageLink: newPrivateEvents[foundIndex].coverImageLink,
                connectedGroupchat:
                    newPrivateEvents[foundIndex].connectedGroupchat,
                eventDate: newPrivateEvents[foundIndex].eventDate,
                usersThatWillBeThere: privateEvent.usersThatWillBeThere,
                usersThatWillNotBeThere: privateEvent.usersThatWillNotBeThere,
                createdBy: newPrivateEvents[foundIndex].createdBy,
                createdAt: newPrivateEvents[foundIndex].createdAt,
              );

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
    });
  }
}
