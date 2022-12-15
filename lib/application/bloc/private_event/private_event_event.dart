part of 'private_event_bloc.dart';

@immutable
abstract class PrivateEventEvent {}

class PrivateEventsRequestEvent extends PrivateEventEvent {}

class PrivateEventInitialEvent extends PrivateEventEvent {}

class PrivateEventCreateEvent extends PrivateEventEvent {
  final CreatePrivateEventDto createPrivateEventDto;

  PrivateEventCreateEvent({required this.createPrivateEventDto});
}
