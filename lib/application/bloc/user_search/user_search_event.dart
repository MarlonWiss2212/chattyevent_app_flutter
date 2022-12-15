part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchEvent {}

class UserSearchInitialEvent extends UserSearchEvent {}

class SearchUsersEvent extends UserSearchEvent {
  final String search;
  SearchUsersEvent({this.search = ""});
}
