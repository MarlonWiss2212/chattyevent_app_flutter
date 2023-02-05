import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'current_chat_state.dart';

class CurrentChatCubit extends Cubit<CurrentChatState> {
  final ChatCubit chatCubit;
  final ChatUseCases chatUseCases;

  CurrentChatCubit(
    super.initialState, {
    required this.chatCubit,
    required this.chatUseCases,
  });

  void reset() {
    emit(CurrentChatInitial(currentChat: GroupchatEntity(id: "")));
  }

  Future getCurrentChatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    emit(CurrentChatLoading(currentChat: state.currentChat));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );

    groupchatOrFailure.fold(
      (error) {
        CurrentChatError(
          currentChat: state.currentChat,
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (groupchat) {
        final mergedChat = chatCubit.editChatIfExistOrAdd(groupchat: groupchat);
        emit(CurrentChatLoaded(currentChat: mergedChat));
      },
    );
  }

  void setCurrentChat({required GroupchatEntity groupchat}) {
    emit(CurrentChatLoading(currentChat: state.currentChat));
    emit(CurrentChatLoaded(currentChat: groupchat));
  }

  Future addUserToChat({
    required String groupchatId,
    required String userIdToAdd,
  }) async {
    emit(CurrentChatLoading(currentChat: state.currentChat));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.addUserToGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToAdd: userIdToAdd,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          currentChat: state.currentChat,
          message: "Fehler",
          title: mapFailureToMessage(error),
        ));
      },
      (groupchat) {
        final mergedChat = chatCubit.editChatIfExistOrAdd(groupchat: groupchat);
        emit(CurrentChatLoaded(currentChat: mergedChat));
      },
    );
  }

  Future deleteUserFromChatEvent({
    required String groupchatId,
    required String userIdToDelete,
  }) async {
    emit(CurrentChatLoading(currentChat: state.currentChat));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.deleteUserFromGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToDelete: userIdToDelete,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          currentChat: state.currentChat,
          message: mapFailureToMessage(error),
          title: "Fehler",
        ));
      },
      (groupchat) {
        final margedChat = chatCubit.editChatIfExistOrAdd(groupchat: groupchat);
        emit(CurrentChatLoaded(currentChat: margedChat));
      },
    );
  }
}
