part of 'edit_private_event_cubit.dart';

@immutable
abstract class EditPrivateEventState {}

class EditPrivateEventInitial extends EditPrivateEventState {}

class EditPrivateEventLoading extends EditPrivateEventState {}

class EditPrivateEventError extends EditPrivateEventState {
  final String title;
  final String message;

  EditPrivateEventError({required this.message, required this.title});
}

class EditPrivateEventLoaded extends EditPrivateEventState {
  final PrivateEventEntity editedPrivateEvent;
  EditPrivateEventLoaded({required this.editedPrivateEvent});
}
