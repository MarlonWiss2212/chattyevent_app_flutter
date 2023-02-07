part of 'current_private_event_cubit.dart';

@immutable
abstract class CurrentPrivateEventState {
  final PrivateEventEntity privateEvent;
  const CurrentPrivateEventState({required this.privateEvent});
}

class CurrentPrivateEventInitial extends CurrentPrivateEventState {
  const CurrentPrivateEventInitial({required super.privateEvent});
}

class CurrentPrivateEventLoading extends CurrentPrivateEventState {
  const CurrentPrivateEventLoading({required super.privateEvent});
}

class CurrentPrivateEventError extends CurrentPrivateEventState {
  final String title;
  final String message;

  const CurrentPrivateEventError({
    required super.privateEvent,
    required this.message,
    required this.title,
  });
}

class CurrentPrivateEventLoaded extends CurrentPrivateEventState {
  const CurrentPrivateEventLoaded({
    required super.privateEvent,
  });
}
