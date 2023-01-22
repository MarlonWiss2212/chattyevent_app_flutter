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

  CurrentChatCubit({
    required this.chatCubit,
    required this.chatUseCases,
  }) : super(CurrentChatInitial());

  void reset() {
    emit(CurrentChatInitial());
  }

  Future getOneChatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    emit(CurrentChatLoading());
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );

    groupchatOrFailure.fold(
      (error) {
        CurrentChatError(
          title: "Fehler",
          message: mapFailureToMessage(error),
        );
      },
      (groupchat) {
        chatCubit.editChatIfExistOrAdd(groupchat: groupchat);
        emit(CurrentChatLoaded());
      },
    );
  }

  Future addUserToChat({
    required String groupchatId,
    required String userIdToAdd,
  }) async {
    emit(CurrentChatEditing());
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.addUserToGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToAdd: userIdToAdd,
    );

    // this has only the users and left users in it
    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          message: "Fehler",
          title: mapFailureToMessage(error),
        ));
      },
      (groupchat) {
        chatCubit.editChatIfExistOrAdd(groupchat: groupchat);
        emit(CurrentChatLoaded());
      },
    );
  }

  Future deleteUserFromChatEvent({
    required String groupchatId,
    required String userIdToDelete,
  }) async {
    emit(CurrentChatEditing());
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.deleteUserFromGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToDelete: userIdToDelete,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(CurrentChatError(
          message: mapFailureToMessage(error),
          title: "Fehler",
        ));
      },
      (groupchat) {
        chatCubit.editChatIfExistOrAdd(groupchat: groupchat);
        emit(CurrentChatLoaded());
      },
    );
  }
}
