part of 'private_event_cubit.dart';

@immutable
abstract class PrivateEventState {}

class PrivateEventInitial extends PrivateEventState {}

class PrivateEventStateLoading extends PrivateEventState {}

class PrivateEventStateError extends PrivateEventState {
  final String title;
  final String message;
  PrivateEventStateError({required this.title, required this.message});
}

class PrivateEventStateLoaded extends PrivateEventState {
  final List<PrivateEventEntity> privateEvents;

  PrivateEventStateLoaded({
    required this.privateEvents,
  });
}
