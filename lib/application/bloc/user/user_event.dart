part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUsersEvent extends UserEvent {
  late final GetUsersFilter getUsersFilter;

  GetUsersEvent({GetUsersFilter? getUsersFilterParam}) {
    if (getUsersFilterParam == null) {
      getUsersFilter = GetUsersFilter();
    } else {
      getUsersFilter = getUsersFilterParam;
    }
  }
}

class UserInitialEvent extends UserEvent {}

class GetOneUserEvent extends UserEvent {
  final GetOneUserFilter getOneUserFilter;
  GetOneUserEvent({required this.getOneUserFilter});
}
