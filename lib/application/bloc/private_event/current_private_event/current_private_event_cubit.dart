import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'current_private_event_state.dart';

class CurrentPrivateEventCubit extends Cubit<CurrentPrivateEventState> {
  final PrivateEventCubit privateEventCubit;
  final PrivateEventUseCases privateEventUseCases;

  CurrentPrivateEventCubit(
    super.initialState, {
    required this.privateEventCubit,
    required this.privateEventUseCases,
  });

  Future getOnePrivateEvent({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    emit(CurrentPrivateEventLoading(privateEvent: state.privateEvent));

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );

    privateEventOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          privateEvent: state.privateEvent,
          message: mapFailureToMessage(error),
          title: "Fehler Geradiges Event",
        ));
      },
      (privateEvent) {
        final mergedPrivateEvent =
            privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );

        emit(CurrentPrivateEventLoaded(privateEvent: mergedPrivateEvent));
      },
    );
  }

  void setCurrentPrivateEvent({required PrivateEventEntity privateEvent}) {
    emit(CurrentPrivateEventLoading(privateEvent: state.privateEvent));
    emit(CurrentPrivateEventLoaded(privateEvent: privateEvent));
  }

  Future updateMeInPrivateEventWillBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventLoading(privateEvent: state.privateEvent));

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updateMeInPrivateEventWillBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        CurrentPrivateEventError(
          privateEvent: state.privateEvent,
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (privateEvent) {
        final mergedPrivateEvent =
            privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventLoaded(privateEvent: mergedPrivateEvent));
      },
    );
  }

  Future updateMeInPrivateEventWillNotBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventLoading(privateEvent: state.privateEvent));

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.updateMeInPrivateEventWillNotBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        CurrentPrivateEventError(
          privateEvent: state.privateEvent,
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (privateEvent) {
        final mergedPrivateEvent =
            privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventLoaded(privateEvent: mergedPrivateEvent));
      },
    );
  }

  Future updateMeInPrivateEventNoInformationOnWillBeThere({
    required String privateEventId,
  }) async {
    emit(CurrentPrivateEventLoading(privateEvent: state.privateEvent));

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases
            .updateMeInPrivateEventNoInformationOnWillBeThere(
      privateEventId: privateEventId,
    );

    privateEventOrFailure.fold(
      (error) {
        CurrentPrivateEventError(
          privateEvent: state.privateEvent,
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (privateEvent) {
        final mergedPrivateEvent =
            privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventLoaded(privateEvent: mergedPrivateEvent));
      },
    );
  }
}
