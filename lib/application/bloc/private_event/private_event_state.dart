part of 'private_event_cubit.dart';

@immutable
abstract class PrivateEventState {
  final List<PrivateEventEntity> privateEvents;

  const PrivateEventState({
    required this.privateEvents,
  });
}

class PrivateEventInitial extends PrivateEventState {
  PrivateEventInitial() : super(privateEvents: []);
}

class PrivateEventLoading extends PrivateEventState {
  const PrivateEventLoading({required super.privateEvents});
}

class PrivateEventError extends PrivateEventState {
  final String title;
  final String message;
  const PrivateEventError({
    required super.privateEvents,
    required this.title,
    required this.message,
  });
}

class PrivateEventLoaded extends PrivateEventState {
  const PrivateEventLoaded({required super.privateEvents});
}
