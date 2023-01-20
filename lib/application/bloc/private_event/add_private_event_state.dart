part of 'add_private_event_cubit.dart';

@immutable
abstract class AddPrivateEventState {}

class AddPrivateEventInitial extends AddPrivateEventState {}

class AddPrivateEventLoading extends AddPrivateEventState {}

class AddPrivateEventError extends AddPrivateEventState {
  final String title;
  final String message;

  AddPrivateEventError({required this.message, required this.title});
}

class AddPrivateEventLoaded extends AddPrivateEventState {
  final PrivateEventEntity addedPrivateEvent;
  AddPrivateEventLoaded({required this.addedPrivateEvent});
}
