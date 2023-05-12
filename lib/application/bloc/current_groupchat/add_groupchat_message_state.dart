part of 'add_groupchat_message_cubit.dart';

enum AddGroupchatMessageStateStatus { initial, loading, success }

class AddGroupchatMessageState {
  final GroupchatMessageEntity? addedMessage;
  final AddGroupchatMessageStateStatus status;

  final File? file;
  final String? message;
  final String? groupchatTo;
  final String? messageToReactTo;

  AddGroupchatMessageState({
    this.addedMessage,
    this.message,
    this.messageToReactTo,
    this.groupchatTo,
    this.file,
    this.status = AddGroupchatMessageStateStatus.initial,
  });
}
