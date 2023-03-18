part of 'current_private_event_cubit.dart';

enum CurrentPrivateEventStateStatus { initial, success, error }

class CurrentPrivateEventState {
  final PrivateEventEntity privateEvent;
  final GroupchatEntity? groupchat;

  final bool loadingPrivateEvent;
  final bool loadingGroupchat;

  final CurrentPrivateEventStateStatus status;
  final ErrorWithTitleAndMessage? error;

  final List<UserWithPrivateEventUserData> privateEventUsers;

  const CurrentPrivateEventState({
    required this.privateEvent,
    required this.privateEventUsers,
    this.groupchat,
    required this.loadingPrivateEvent,
    required this.loadingGroupchat,
    this.status = CurrentPrivateEventStateStatus.initial,
    this.error,
  });
}
