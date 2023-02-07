part of 'profile_page_cubit.dart';

@immutable
abstract class ProfilePageState {
  final UserEntity user;
  const ProfilePageState({required this.user});
}

class ProfilePageInitial extends ProfilePageState {
  const ProfilePageInitial({required super.user});
}

class ProfilePageLoading extends ProfilePageState {
  const ProfilePageLoading({required super.user});
}

class ProfilePageError extends ProfilePageState {
  final String title;
  final String message;
  const ProfilePageError({
    required this.title,
    required this.message,
    required super.user,
  });
}

class ProfilePageLoaded extends ProfilePageState {
  const ProfilePageLoaded({required super.user});
}
