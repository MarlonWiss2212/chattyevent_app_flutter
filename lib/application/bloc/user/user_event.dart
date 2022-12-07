part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUsersEvent extends UserEvent {
  final String? search;
  GetUsersEvent({this.search});
}

class GetOneUserEvent extends UserEvent {
  final String? email;
  final String? userId;
  GetOneUserEvent({this.email, this.userId});
}
