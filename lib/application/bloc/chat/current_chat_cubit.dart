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

  Future getCurrentChatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    emit(CurrentChatNormal(currentChat: state.currentChat, loadingChat: true));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          currentChat: state.currentChat,
          title: "Fehler",
          message: mapFailureToMessage(error),
          loadingChat: false,
        ));
      },
      (groupchat) {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(CurrentChatNormal(currentChat: mergedChat, loadingChat: false));
      },
    );
  }

  void setCurrentChat({required GroupchatEntity groupchat}) {
    emit(CurrentChatNormal(
      currentChat: groupchat,
      loadingChat: state.loadingChat,
    ));
  }

  Future addUserToChat({
    required String groupchatId,
    required String userIdToAdd,
  }) async {
    emit(CurrentChatNormal(currentChat: state.currentChat, loadingChat: true));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.addUserToGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToAdd: userIdToAdd,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          loadingChat: false,
          currentChat: state.currentChat,
          message: "Fehler",
          title: mapFailureToMessage(error),
        ));
      },
      (groupchat) {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(CurrentChatNormal(currentChat: mergedChat, loadingChat: false));
      },
    );
  }

  Future deleteUserFromChatEvent({
    required String groupchatId,
    required String userIdToDelete,
  }) async {
    emit(CurrentChatNormal(currentChat: state.currentChat, loadingChat: true));

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.deleteUserFromGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToDelete: userIdToDelete,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          loadingChat: false,
          currentChat: state.currentChat,
          message: mapFailureToMessage(error),
          title: "Fehler",
        ));
      },
      (groupchat) {
        final mergedChat = chatCubit.mergeOrAdd(groupchat: groupchat);
        emit(CurrentChatNormal(currentChat: mergedChat, loadingChat: false));
      },
    );
  }
}
