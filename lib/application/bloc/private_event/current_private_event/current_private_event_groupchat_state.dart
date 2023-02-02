part of 'current_private_event_groupchat_cubit.dart';

@immutable
abstract class CurrentPrivateEventGroupchatState {}

class CurrentPrivateEventGroupchatInitial
    extends CurrentPrivateEventGroupchatState {}

class CurrentPrivateEventGroupchatLoading
    extends CurrentPrivateEventGroupchatState {}

class CurrentPrivateEventGroupchatError
    extends CurrentPrivateEventGroupchatState {
  final String title;
  final String message;

  CurrentPrivateEventGroupchatError({
    required this.message,
    required this.title,
  });
}

class CurrentPrivateEventGroupchatLoaded
    extends CurrentPrivateEventGroupchatState {
  final GroupchatEntity groupchat;
  CurrentPrivateEventGroupchatLoaded({required this.groupchat});
}
