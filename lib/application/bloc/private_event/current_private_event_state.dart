part of 'current_private_event_cubit.dart';

@immutable
abstract class CurrentPrivateEventState {}

class CurrentPrivateEventInitial extends CurrentPrivateEventState {}

class CurrentPrivateEventLoading extends CurrentPrivateEventState {}

class CurrentPrivateEventEditing extends CurrentPrivateEventState {}

class CurrentPrivateEventError extends CurrentPrivateEventState {
  final String title;
  final String message;

  CurrentPrivateEventError({required this.message, required this.title});
}

class CurrentPrivateEventLoaded extends CurrentPrivateEventState {}
