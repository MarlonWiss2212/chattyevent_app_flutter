part of 'user_profile_bloc.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileStateLoading extends UserProfileState {}

class UserProfileStateError extends UserProfileState {
  final String message;
  UserProfileStateError({required this.message});
}

class UserProfileStateLoaded extends UserProfileState {
  final UserEntity userProfile;
  UserProfileStateLoaded({required this.userProfile});
}
