import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
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
