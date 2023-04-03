import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/error_with_title_and_message.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';

part 'private_event_state.dart';

class PrivateEventCubit extends Cubit<PrivateEventState> {
  final PrivateEventUseCases privateEventUseCases;
  PrivateEventCubit({
    required this.privateEventUseCases,
  }) : super(const PrivateEventState(privateEvents: []));

  PrivateEventEntity replaceOrAdd({
    required PrivateEventEntity privateEvent,
    required bool mergeChatSetUsersFromOldEntity,
  }) {
    int foundIndex = state.privateEvents.indexWhere(
      (element) => element.id == privateEvent.id,
    );

    if (foundIndex != -1) {
      List<PrivateEventEntity> newPrivateEvents = state.privateEvents;
      newPrivateEvents[foundIndex] = PrivateEventEntity.merge(
        newEntity: privateEvent,
        oldEntity: state.privateEvents[foundIndex],
        mergeChatSetUsersFromOldEntity: mergeChatSetUsersFromOldEntity,
      );
      emitState(privateEvents: newPrivateEvents);
      return newPrivateEvents[foundIndex];
    } else {
      emitState(
        privateEvents: List.from(state.privateEvents)..add(privateEvent),
      );
    }
    return privateEvent;
  }

  List<PrivateEventEntity> replaceOrAddMultiple({
    required List<PrivateEventEntity> privateEvents,
    required bool mergeChatSetUsersFromOldEntity,
  }) {
    List<PrivateEventEntity> mergedPrivateEvents = [];
    for (final privateEvent in privateEvents) {
      final mergedPrivateEvent = replaceOrAdd(
        privateEvent: privateEvent,
        mergeChatSetUsersFromOldEntity: mergeChatSetUsersFromOldEntity,
      );
      mergedPrivateEvents.add(mergedPrivateEvent);
    }
    return mergedPrivateEvents;
  }

  void delete({required String privateEventId}) {
    List<PrivateEventEntity> newPrivateEvents = state.privateEvents;
    newPrivateEvents.removeWhere(
      (element) => element.id == privateEventId,
    );
    emitState(privateEvents: newPrivateEvents);
  }

  Future getPrivateEventsViaApi() async {
    emitState(
      privateEvents: state.privateEvents,
      status: PrivateEventStateStatus.loading,
    );

    final Either<Failure, List<PrivateEventEntity>> privateEventOrFailure =
        await privateEventUseCases.getPrivateEventsViaApi(
      limitOffsetFilter: LimitOffsetFilter(
        limit: 10000,
        offset: 0,
      ),
    );

    privateEventOrFailure.fold(
      (error) => emitState(
        privateEvents: state.privateEvents,
        status: PrivateEventStateStatus.error,
        error: ErrorWithTitleAndMessage(
          title: "Fehler",
          message: mapFailureToMessage(error),
        ),
      ),
      (privateEvents) {
        emitState(status: PrivateEventStateStatus.success);
        replaceOrAddMultiple(
          privateEvents: privateEvents,
          mergeChatSetUsersFromOldEntity: false,
        );
      },
    );
  }

  emitState({
    List<PrivateEventEntity>? privateEvents,
    PrivateEventStateStatus? status,
    String? loadingForPrivateEventId,
    ErrorWithTitleAndMessage? error,
  }) {
    emit(
      PrivateEventState(
        privateEvents: privateEvents ?? state.privateEvents,
        error: error,
        status: status ?? PrivateEventStateStatus.initial,
      ),
    );
  }
}
