import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'add_chat_state.dart';

class AddChatCubit extends Cubit<AddChatState> {
  final ChatCubit chatCubit;
  final ChatUseCases chatUseCases;
  AddChatCubit({
    required this.chatCubit,
    required this.chatUseCases,
  }) : super(AddChatInitial());

  void reset() {
    emit(AddChatInitial());
  }

  Future createChat({required CreateGroupchatDto createGroupchatDto}) async {
    emit(AddChatLoading());

    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.createGroupchatViaApi(
      createGroupchatDto: createGroupchatDto,
    );

    groupchatOrFailure.fold(
      (error) {
        emit(
          AddChatError(title: "Fehler", message: mapFailureToMessage(error)),
        );
      },
      (groupchat) {
        chatCubit.addChat(groupchat: groupchat);
        emit(AddChatLoaded(addedChat: groupchat));
      },
    );
  }
}
