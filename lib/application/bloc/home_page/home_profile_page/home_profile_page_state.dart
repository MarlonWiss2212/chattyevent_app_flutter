part of 'home_profile_page_cubit.dart';

@immutable
abstract class HomeProfilePageState {}

abstract class HomeProfilePageWithUser extends HomeProfilePageState {
  final UserEntity user;
  HomeProfilePageWithUser({required this.user});
}

class HomeProfilePageInitial extends HomeProfilePageState {}

class HomeProfilePageLoading extends HomeProfilePageState {}

class HomeProfilePageEditing extends HomeProfilePageWithUser {
  HomeProfilePageEditing({required super.user});
}

class HomeProfilePageError extends HomeProfilePageState {
  final String title;
  final String message;
  HomeProfilePageError({required this.message, required this.title});
}

class HomeProfilePageLoaded extends HomeProfilePageWithUser {
  HomeProfilePageLoaded({required super.user});
}
