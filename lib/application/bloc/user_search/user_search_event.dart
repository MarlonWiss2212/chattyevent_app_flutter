part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchEvent {}

class UserSearchInitialEvent extends UserSearchEvent {}

class UserSearchGetUsersEvent extends UserSearchEvent {
  late final GetUsersFilter getUsersFilter;

  UserSearchGetUsersEvent({GetUsersFilter? getUsersFilterParam}) {
    getUsersFilterParam == null
        ? getUsersFilter = GetUsersFilter()
        : getUsersFilter = getUsersFilterParam;
  }
}
