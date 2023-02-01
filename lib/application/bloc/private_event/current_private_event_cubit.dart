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
  final ChatCubit chatCubit;

  final PrivateEventUseCases privateEventUseCases;
  final ChatUseCases chatUseCases;

  CurrentPrivateEventCubit({
    required this.privateEventCubit,
    required this.chatCubit,
    required this.privateEventUseCases,
    required this.chatUseCases,
  }) : super(CurrentPrivateEventInitial());

  void reset() {
    emit(CurrentPrivateEventInitial());
  }

  Future getOnePrivateEvent({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
    bool loadGroupchat = false,
  }) async {
    emit(CurrentPrivateEventLoading());

    final Either<Failure, PrivateEventEntity> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventViaApi(
      getOnePrivateEventFilter: getOnePrivateEventFilter,
    );

    await privateEventOrFailure.fold(
      (error) {
        emit(CurrentPrivateEventError(
          message: mapFailureToMessage(error),
          title: "Fehler Geradiges Event",
        ));
      },
      (privateEvent) async {
        final mergedPrivateEvent =
            privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );

        if (loadGroupchat) {
          emit(
            CurrentPrivateEventLoadingGroupchat(
              privateEvent: mergedPrivateEvent,
            ),
          );

          await getGroupchatViaApi();
        } else {
          emit(CurrentPrivateEventLoaded(privateEvent: mergedPrivateEvent));
        }
      },
    );
  }

  void setCurrentPrivateEvent({required PrivateEventEntity privateEvent}) {
    emit(CurrentPrivateEventLoading());
    emit(CurrentPrivateEventLoaded(privateEvent: privateEvent));
  }

  Future getGroupchatViaApi() async {
    if (state is CurrentPrivateEventStateWithPrivateEvent) {
      final state = this.state as CurrentPrivateEventStateWithPrivateEvent;

      emit(
        CurrentPrivateEventLoadingGroupchat(privateEvent: state.privateEvent),
      );

      if (state.privateEvent.connectedGroupchat == null) {
        emit(
          CurrentPrivateEventErrorGroupchat(
            message:
                "Kann den zugehörigen Chat nicht Laden, da das Event keinen verbundenen Chat kennt",
            title: "Lade Fehler",
            privateEvent: state.privateEvent,
          ),
        );
        return;
      }

      final Either<Failure, GroupchatEntity> groupchatOrFailure =
          await chatUseCases.getGroupchatViaApi(
        getOneGroupchatFilter:
            GetOneGroupchatFilter(id: state.privateEvent.connectedGroupchat!),
      );

      groupchatOrFailure.fold(
        (error) {
          emit(
            CurrentPrivateEventErrorGroupchat(
              message: mapFailureToMessage(error),
              title: "Fehler",
              privateEvent: state.privateEvent,
            ),
          );
        },
        (groupchat) {
          final mergedChat = chatCubit.editChatIfExistOrAdd(
            groupchat: groupchat,
          );
          emit(
            CurrentPrivateEventLoadedGroupchat(
              privateEvent: state.privateEvent,
              groupchat: mergedChat,
            ),
          );
        },
      );
    } else {
      emit(
        CurrentPrivateEventError(
          message:
              "Der zugehörige Chat kann nicht vor dem Event geladen werden",
          title: "Lade Fehler",
        ),
      );
    }
  }

  Future updateMeInPrivateEventWillBeThere({
    required String privateEventId,
  }) async {
    final state = this.state as CurrentPrivateEventStateWithPrivateEvent;
    emit(CurrentPrivateEventEditing(privateEvent: state.privateEvent));
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
    final state = this.state as CurrentPrivateEventStateWithPrivateEvent;
    emit(CurrentPrivateEventEditing(privateEvent: state.privateEvent));

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
    final state = this.state as CurrentPrivateEventStateWithPrivateEvent;
    emit(CurrentPrivateEventEditing(privateEvent: state.privateEvent));

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
        final mergedPrivateEvent =
            privateEventCubit.editPrivateEventIfExistOrAdd(
          privateEvent: privateEvent,
        );
        emit(CurrentPrivateEventLoaded(privateEvent: mergedPrivateEvent));
      },
    );
  }
}
