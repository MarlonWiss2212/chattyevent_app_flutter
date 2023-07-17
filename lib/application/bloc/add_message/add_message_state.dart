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
  final MessageAndUserEntity? messageToReactToWithUser;

  // current message location
  final double? lat;
  final double? lon;

  AddMessageState({
    this.lat,
    this.lon,
    this.addedMessage,
    this.message,
    this.messageToReactToWithUser,
    this.groupchatTo,
    this.privateEventTo,
    this.userTo,
    this.file,
    this.status = AddMessageStateStatus.initial,
  });
}
