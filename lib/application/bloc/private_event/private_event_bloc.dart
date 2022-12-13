import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/domain/dto/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'private_event_event.dart';
part 'private_event_state.dart';

class PrivateEventBloc extends Bloc<PrivateEventEvent, PrivateEventState> {
  final PrivateEventUseCases privateEventUseCases;

  PrivateEventBloc({required this.privateEventUseCases})
      : super(PrivateEventInitial()) {
    on<PrivateEventEvent>((event, emit) {});

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
            ));
          } else {
            emit(PrivateEventStateLoaded(privateEvents: [privateEvent]));
          }
        },
      );
    });

    on<PrivateEventsRequestEvent>((event, emit) async {
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
  }
}
