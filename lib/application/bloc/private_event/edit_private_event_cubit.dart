import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'edit_private_event_state.dart';

class EditPrivateEventCubit extends Cubit<EditPrivateEventState> {
  final PrivateEventCubit privateEventCubit;
  final PrivateEventUseCases privateEventUseCases;

  EditPrivateEventCubit({
    required this.privateEventCubit,
    required this.privateEventUseCases,
  }) : super(EditPrivateEventInitial());

  void reset() {
    emit(EditPrivateEventInitial());
  }

  Future updateMeInPrivateEventWillBeThere({
    required String privateEventId,
  }) async {
    emit(EditPrivateEventLoading());
    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updateMeInPrivateEventWillBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        EditPrivateEventError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (privateEvent) {
        privateEventCubit.editPrivateEvent(privateEvent: privateEvent);
        emit(EditPrivateEventLoaded(editedPrivateEvent: privateEvent));
      },
    );
  }

  Future updateMeInPrivateEventWillNotBeThere({
    required String privateEventId,
  }) async {
    emit(EditPrivateEventLoading());
    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updateMeInPrivateEventWillNotBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        EditPrivateEventError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (privateEvent) {
        privateEventCubit.editPrivateEvent(privateEvent: privateEvent);
        emit(EditPrivateEventLoaded(editedPrivateEvent: privateEvent));
      },
    );
  }

  Future updateMeInPrivateEventNoInformationOnWillBeThere({
    required String privateEventId,
  }) async {
    emit(EditPrivateEventLoading());
    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases
            .updateMeInPrivateEventNoInformationOnWillBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        EditPrivateEventError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (privateEvent) {
        privateEventCubit.editPrivateEvent(privateEvent: privateEvent);
        emit(EditPrivateEventLoaded(editedPrivateEvent: privateEvent));
      },
    );
  }
}
