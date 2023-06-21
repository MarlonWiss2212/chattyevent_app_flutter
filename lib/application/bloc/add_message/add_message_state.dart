part of 'add_message_cubit.dart';

enum AddMessageStateStatus { initial, loading, success }

class AddMessageState {
  final MessageEntity? addedMessage;
  final AddMessageStateStatus status;

  final File? file;
  final String? message;
  final String? groupchatTo;
  final String? privateEventTo;
  final String? userTo;
  final MessageEntity? messageToReactTo;

  AddMessageState({
    this.addedMessage,
    this.message,
    this.messageToReactTo,
    this.groupchatTo,
    this.privateEventTo,
    this.userTo,
    this.file,
    this.status = AddMessageStateStatus.initial,
  });
}
