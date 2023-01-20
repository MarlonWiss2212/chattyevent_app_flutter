import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'add_private_event_state.dart';

class AddPrivateEventCubit extends Cubit<AddPrivateEventState> {
  final PrivateEventCubit privateEventCubit;
  final PrivateEventUseCases privateEventUseCases;

  AddPrivateEventCubit({
    required this.privateEventUseCases,
    required this.privateEventCubit,
  }) : super(AddPrivateEventInitial());

  void reset() {
    emit(AddPrivateEventInitial());
  }

  Future createPrivateEvent({
    required CreatePrivateEventDto createPrivateEventDto,
  }) async {
    emit(AddPrivateEventLoading());
    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases
            .createPrivateEventViaApi(createPrivateEventDto);

    privateEventOrFailure.fold(
      (error) {
        emit(AddPrivateEventError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ));
      },
      (privateEvent) {
        privateEventCubit.addPrivateEvent(privateEvent: privateEvent);
        emit(AddPrivateEventLoaded(addedPrivateEvent: privateEvent));
      },
    );
  }
}
