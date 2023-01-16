import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCases chatUseCases;
  ChatCubit({required this.chatUseCases}) : super(ChatInitial());

  void reset() {
    emit(ChatInitial());
  }

  void addChat({required GroupchatEntity groupchat}) {
    if (state is ChatStateLoaded) {
      final state = this.state as ChatStateLoaded;
      emit(
        ChatStateLoaded(
          chats: List.from(state.chats)..add(groupchat),
        ),
      );
    } else {
      emit(ChatStateLoaded(chats: [groupchat]));
    }
  }

  Future getChats() async {
    emit(ChatStateLoading());

    final Either<Failure, List<GroupchatEntity>> groupchatsOrFailure =
        await chatUseCases.getGroupchatsViaApi();

    groupchatsOrFailure.fold(
      (error) => emit(
        ChatStateError(message: mapFailureToMessage(error)),
      ),
      (groupchats) => emit(
        ChatStateLoaded(chats: groupchats),
      ),
    );
  }

  Future getOneChat({
    required GetOneGroupchatFilter getOneGroupchatFilter,
  }) async {
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.getGroupchatViaApi(
      getOneGroupchatFilter: getOneGroupchatFilter,
    );

    groupchatOrFailure.fold(
      (error) {
        if (state is ChatStateLoaded) {
          final state = this.state as ChatStateLoaded;
          emit(
            ChatStateLoaded(
              chats: state.chats,
              errorMessage: mapFailureToMessage(error),
            ),
          );
        } else {
          emit(
            ChatStateError(
              message: mapFailureToMessage(error),
            ),
          );
        }
      },
      (groupchat) {
        if (state is ChatStateLoaded) {
          final state = this.state as ChatStateLoaded;

          int foundIndex = -1;
          state.chats.asMap().forEach((index, chatToFind) {
            if (chatToFind.id == groupchat.id) {
              foundIndex = index;
            }
          });

          if (foundIndex != -1) {
            List<GroupchatEntity> newGroupchats = state.chats;
            newGroupchats[foundIndex] = groupchat;
            emit(
              ChatStateLoaded(chats: newGroupchats),
            );
          } else {
            emit(
              ChatStateLoaded(chats: List.from(state.chats)..add(groupchat)),
            );
          }
        } else {
          emit(
            ChatStateLoaded(
              chats: [groupchat],
            ),
          );
        }
      },
    );
  }

  Future addUserToChat({
    required String groupchatId,
    required String userIdToAdd,
  }) async {
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.addUserToGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToAdd: userIdToAdd,
    );

    // this has only the users and left users in it
    groupchatOrFailure.fold(
      (error) {
        if (state is ChatStateLoaded) {
          final state = this.state as ChatStateLoaded;
          emit(
            ChatStateLoaded(
              chats: state.chats,
              errorMessage: mapFailureToMessage(error),
            ),
          );
        } else {
          emit(ChatStateError(message: mapFailureToMessage(error)));
        }
      },
      (groupchat) {
        if (state is ChatStateLoaded) {
          final state = this.state as ChatStateLoaded;

          int foundIndex = -1;
          state.chats.asMap().forEach((index, chatToFind) {
            if (chatToFind.id == groupchat.id) {
              foundIndex = index;
            }
          });

          if (foundIndex != -1) {
            List<GroupchatEntity> newGroupchats = state.chats;
            newGroupchats[foundIndex] = GroupchatEntity(
              id: groupchat.id,
              title: newGroupchats[foundIndex].title,
              description: newGroupchats[foundIndex].description,
              users: groupchat.users,
              leftUsers: groupchat.leftUsers,
              createdBy: newGroupchats[foundIndex].createdBy,
              createdAt: newGroupchats[foundIndex].createdAt,
            );
            emit(
              ChatStateLoaded(chats: newGroupchats),
            );
          } else {
            emit(
              ChatStateLoaded(chats: List.from(state.chats)..add(groupchat)),
            );
          }
        } else {
          emit(
            ChatStateLoaded(
              chats: [groupchat],
            ),
          );
        }
      },
    );
  }

  Future deleteUserFromChatEvent({
    required String groupchatId,
    required String userIdToDelete,
  }) async {
    final Either<Failure, GroupchatEntity> groupchatOrFailure =
        await chatUseCases.deleteUserFromGroupchatViaApi(
      groupchatId: groupchatId,
      userIdToDelete: userIdToDelete,
    );

    // this has only the users and left users in it
    groupchatOrFailure.fold(
      (error) {
        if (state is ChatStateLoaded) {
          final state = this.state as ChatStateLoaded;
          emit(
            ChatStateLoaded(
              chats: state.chats,
              errorMessage: mapFailureToMessage(error),
            ),
          );
        } else {
          emit(ChatStateError(message: mapFailureToMessage(error)));
        }
      },
      (groupchat) {
        if (state is ChatStateLoaded) {
          final state = this.state as ChatStateLoaded;

          int foundIndex = -1;
          state.chats.asMap().forEach((index, chatToFind) {
            if (chatToFind.id == groupchat.id) {
              foundIndex = index;
            }
          });

          if (foundIndex != -1) {
            List<GroupchatEntity> newGroupchats = state.chats;
            newGroupchats[foundIndex] = GroupchatEntity(
              id: groupchat.id,
              title: newGroupchats[foundIndex].title,
              description: newGroupchats[foundIndex].description,
              users: groupchat.users,
              leftUsers: groupchat.leftUsers,
              createdBy: newGroupchats[foundIndex].createdBy,
              createdAt: newGroupchats[foundIndex].createdAt,
            );
            emit(
              ChatStateLoaded(chats: newGroupchats),
            );
          } else {
            emit(
              ChatStateLoaded(chats: List.from(state.chats)..add(groupchat)),
            );
          }
        } else {
          emit(
            ChatStateLoaded(
              chats: [groupchat],
            ),
          );
        }
      },
    );
  }
}
