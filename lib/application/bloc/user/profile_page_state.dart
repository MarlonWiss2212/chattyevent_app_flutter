part of 'profile_page_cubit.dart';

@immutable
abstract class ProfilePageState {}

abstract class ProfilePageStateWithUser extends ProfilePageState {
  final UserEntity user;
  ProfilePageStateWithUser({required this.user});
}

class ProfilePageInitial extends ProfilePageState {}

class ProfilePageLoading extends ProfilePageState {}

class ProfilePageEditing extends ProfilePageStateWithUser {
  ProfilePageEditing({required super.user});
}

class ProfilePageError extends ProfilePageState {
  final String title;
  final String message;
  ProfilePageError({required this.title, required this.message});
}

class ProfilePageLoaded extends ProfilePageStateWithUser {
  ProfilePageLoaded({required super.user});
}
