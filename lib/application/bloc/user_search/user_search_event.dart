part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchEvent {}

class UserSearchRequestEvent extends UserSearchEvent {
  final String? search;

  UserSearchRequestEvent({this.search});
}
