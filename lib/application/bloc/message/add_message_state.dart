part of 'add_message_cubit.dart';

@immutable
abstract class AddMessageState {}

class AddMessageInitial extends AddMessageState {}

class AddMessageLoading extends AddMessageState {}

class AddMessageError extends AddMessageState {
  final String title;
  final String message;

  AddMessageError({required this.message, required this.title});
}

class AddMessageLoaded extends AddMessageState {
  final MessageEntity addedMessage;
  AddMessageLoaded({required this.addedMessage});
}
