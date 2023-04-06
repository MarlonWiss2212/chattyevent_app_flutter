part of 'add_message_cubit.dart';

enum AddMessageStateStatus { initial, loading, success }

class AddMessageState {
  final MessageEntity? addedMessage;
  final AddMessageStateStatus status;

  final File? file;
  final String? message;
  final String? groupchatTo;
  final String? messageToReactTo;

  AddMessageState({
    this.addedMessage,
    this.message,
    this.messageToReactTo,
    this.groupchatTo,
    this.file,
    this.status = AddMessageStateStatus.initial,
  });
}
