part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationAlert extends NotificationState {
  final String title;
  final String message;

  final OperationException? exception;

  NotificationAlert({
    this.exception,
    required this.title,
    required this.message,
  });
}
