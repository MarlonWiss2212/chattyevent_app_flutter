part of 'private_event_bloc.dart';

@immutable
abstract class PrivateEventEvent {}

class PrivateEventInitialEvent extends PrivateEventEvent {}

class GetPrivateEventsEvent extends PrivateEventEvent {}

class GetOnePrivateEventEvent extends PrivateEventEvent {
  final GetOnePrivateEventFilter getOnePrivateEventEvent;
  GetOnePrivateEventEvent({required this.getOnePrivateEventEvent});
}

class PrivateEventCreateEvent extends PrivateEventEvent {
  final CreatePrivateEventDto createPrivateEventDto;
  PrivateEventCreateEvent({required this.createPrivateEventDto});
}

class UpdateMeInPrivateEventWillBeThereEvent extends PrivateEventEvent {
  final String privateEventId;
  UpdateMeInPrivateEventWillBeThereEvent({required this.privateEventId});
}

class UpdateMeInPrivateEventWillNotBeThereEvent extends PrivateEventEvent {
  final String privateEventId;
  UpdateMeInPrivateEventWillNotBeThereEvent({required this.privateEventId});
}
