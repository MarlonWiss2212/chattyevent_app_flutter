part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchEvent {}

class UserSearchInitialEvent extends UserSearchEvent {}

class UserSearchGetUsersEvent extends UserSearchEvent {
  final String search;
  UserSearchGetUsersEvent({this.search = ""});
}
