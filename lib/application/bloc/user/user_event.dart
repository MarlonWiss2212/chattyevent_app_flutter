part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserRequestEvent extends UserEvent {
  final String? search;
  UserRequestEvent({this.search});
}
