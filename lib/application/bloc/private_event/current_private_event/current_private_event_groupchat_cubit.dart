import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'current_private_event_groupchat_state.dart';

class CurrentPrivateEventGroupchatCubit
    extends Cubit<CurrentPrivateEventGroupchatState> {
  final ChatCubit chatCubit;
  final CurrentPrivateEventCubit currentPrivateEventCubit;
  final ChatUseCases chatUseCases;

  CurrentPrivateEventGroupchatCubit({
    required this.chatCubit,
    required this.currentPrivateEventCubit,
    required this.chatUseCases,
  }) : super(CurrentPrivateEventGroupchatInitial());

  Future setCurrentGroupchatViaApi() async {
    emit(CurrentPrivateEventGroupchatLoading());

    if (currentPrivateEventCubit.state
        is! CurrentPrivateEventStateWithPrivateEvent) {
      return emit(
        CurrentPrivateEventGroupchatError(
          message:
              "Du kannst den zugehörigen Gruppenchat erst nach dem Event laden",
          title: "Event Fehler",
        ),
      );
    }

    final privateEventState = currentPrivateEventCubit.state
        as CurrentPrivateEventStateWithPrivateEvent;

    if (privateEventState.privateEvent.connectedGroupchat == null) {
      return emit(
        CurrentPrivateEventGroupchatError(
          message:
              "Konnte den zugehörigen Gruppenchat in den Event Details nicht Finden",
          title: "Gruppenchat Fehler",
        ),
      );
    }

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: GetOneGroupchatFilter(
        id: privateEventState.privateEvent.connectedGroupchat!,
      ),
    );

    groupchatOrFailure.fold(
      (error) {
        emit(
          CurrentPrivateEventGroupchatError(
            message: mapFailureToMessage(error),
            title: "Fehler",
          ),
        );
      },
      (groupchat) {
        final mergedChat = chatCubit.editChatIfExistOrAdd(
          groupchat: groupchat,
        );
        emit(
          CurrentPrivateEventGroupchatLoaded(
            groupchat: mergedChat,
          ),
        );
      },
    );
  }
}
