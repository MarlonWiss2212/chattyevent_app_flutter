import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'current_private_event_state.dart';

class CurrentPrivateEventCubit extends Cubit<CurrentPrivateEventState> {
  final PrivateEventCubit privateEventCubit;
  final PrivateEventUseCases privateEventUseCases;

  CurrentPrivateEventCubit({
    required this.privateEventCubit,
    required this.privateEventUseCases,
  }) : super(CurrentPrivateEventInitial());

  void reset() {
    emit(CurrentPrivateEventInitial());
  }

  Future getOnePrivateEvent({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    emit(CurrentPrivateEventLoading());

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );

    privateEventOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          message: mapFailureToMessage(error),
          title: "Fehler Geradiges Event",
        ));
      },
      (privateEvent) {
        privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventLoaded());
      },
    );
  }

  Future updateMeInPrivateEventWillBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventEditing());
    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updateMeInPrivateEventWillBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        CurrentPrivateEventError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (privateEvent) {
        privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventLoaded());
      },
    );
  }

  Future updateMeInPrivateEventWillNotBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventEditing());
    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updateMeInPrivateEventWillNotBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        CurrentPrivateEventError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (privateEvent) {
        privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventLoaded());
      },
    );
  }

  Future updateMeInPrivateEventNoInformationOnWillBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventEditing());
    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases
            .updateMeInPrivateEventNoInformationOnWillBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        CurrentPrivateEventError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (privateEvent) {
        privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventLoaded());
      },
    );
  }
}
