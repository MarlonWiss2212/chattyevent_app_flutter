import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'edit_chat_state.dart';

class EditChatCubit extends Cubit<EditChatState> {
  final ChatCubit chatCubit;
  final ChatUseCases chatUseCases;

  EditChatCubit({
    required this.chatCubit,
    required this.chatUseCases,
  }) : super(EditChatInitial());

  void reset() {
    emit(EditChatInitial());
  }

  Future addUserToChat({
    required String groupchatId,
    required String userIdToAdd,
  }) async {
    emit(EditChatLoading());
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.addUserToGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToAdd: userIdToAdd,
    );

    // this has only the users and left users in it
    groupchatOrFailure.fold(
      (error) {
        emit(EditChatError(
          message: "Fehler",
          title: mapFailureToMessage(error),
        ));
      },
      (groupchat) {
        chatCubit.editChat(groupchat: groupchat);
        emit(EditChatLoaded(editedChat: groupchat));
      },
    );
  }

  Future deleteUserFromChatEvent({
    required String groupchatId,
    required String userIdToDelete,
  }) async {
    emit(EditChatLoading());
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.deleteUserFromGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToDelete: userIdToDelete,
    );

    // this has only the users and left users in it
    groupchatOrFailure.fold(
      (error) {
        emit(EditChatError(
          message: mapFailureToMessage(error),
          title: "Fehler",
        ));
      },
      (groupchat) {
        chatCubit.editChat(groupchat: groupchat);
        emit(EditChatLoaded(editedChat: groupchat));
      },
    );
  }
}
