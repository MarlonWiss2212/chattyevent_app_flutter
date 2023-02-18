part of 'add_message_cubit.dart';

enum AddMessageStateStatus { initial, loading, success, error }

class AddMessageState {
  final MessageEntity? addedMessage;
  final ErrorWithTitleAndMessage? error;
  final AddMessageStateStatus status;

  AddMessageState({
    this.addedMessage,
    this.error,
    this.status = AddMessageStateStatus.initial,
  });
}
