part of 'current_private_event_cubit.dart';

@immutable
abstract class CurrentPrivateEventState {}

abstract class CurrentPrivateEventStateWithPrivateEvent
    extends CurrentPrivateEventState {
  final PrivateEventEntity privateEvent;
  CurrentPrivateEventStateWithPrivateEvent({required this.privateEvent});
}

class CurrentPrivateEventInitial extends CurrentPrivateEventState {}

class CurrentPrivateEventLoading extends CurrentPrivateEventState {}

class CurrentPrivateEventEditing
    extends CurrentPrivateEventStateWithPrivateEvent {
  CurrentPrivateEventEditing({required super.privateEvent});
}

class CurrentPrivateEventError extends CurrentPrivateEventState {
  final String title;
  final String message;

  CurrentPrivateEventError({required this.message, required this.title});
}

class CurrentPrivateEventLoaded
    extends CurrentPrivateEventStateWithPrivateEvent {
  CurrentPrivateEventLoaded({required super.privateEvent});
}
