part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUsersEvent extends UserEvent {
  final String? search;
  GetUsersEvent({this.search});
}

class UserInitialEvent extends UserEvent {}

class GetOneUserEvent extends UserEvent {
  final GetOneUserFilter getOneUserFilter;
  GetOneUserEvent({required this.getOneUserFilter});
}
