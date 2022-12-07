part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchEvent {}

class SearchUsersEvent extends UserSearchEvent {
  final String search;
  SearchUsersEvent({this.search = ""});
}
