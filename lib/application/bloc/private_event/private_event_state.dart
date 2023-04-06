part of 'private_event_cubit.dart';

enum PrivateEventStateStatus { initial, loading, success }

class PrivateEventState {
  final List<PrivateEventEntity> privateEvents;
  final PrivateEventStateStatus status;

  const PrivateEventState({
    required this.privateEvents,
    this.status = PrivateEventStateStatus.initial,
  });
}
