part of 'private_event_bloc.dart';

@immutable
abstract class PrivateEventState {}

class PrivateEventInitial extends PrivateEventState {}

class PrivateEventStateLoading extends PrivateEventState {}

class PrivateEventStateError extends PrivateEventState {
  final String message;
  PrivateEventStateError({required this.message});
}

class PrivateEventStateLoaded extends PrivateEventState {
  final List<PrivateEventEntity> privateEvents;
  final String? errorMessage;
  final String? createdPrivateEventId;

  PrivateEventStateLoaded({
    required this.privateEvents,
    this.errorMessage,
    this.createdPrivateEventId,
  });
}
