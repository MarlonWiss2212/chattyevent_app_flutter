part of 'private_event_cubit.dart';

enum PrivateEventStateStatus { initial, loading, success, error }

class PrivateEventState {
  final List<PrivateEventEntity> privateEvents;
  final PrivateEventStateStatus status;
  final ErrorWithTitleAndMessage? error;

  const PrivateEventState({
    required this.privateEvents,
    this.status = PrivateEventStateStatus.initial,
    this.error,
  });
}
