part of 'home_profile_page_cubit.dart';

@immutable
abstract class HomeProfilePageState {
  final UserEntity user;
  const HomeProfilePageState({required this.user});
}

class HomeProfilePageInitial extends HomeProfilePageState {
  const HomeProfilePageInitial({required super.user});
}

class HomeProfilePageLoading extends HomeProfilePageState {
  const HomeProfilePageLoading({required super.user});
}

class HomeProfilePageError extends HomeProfilePageState {
  final String title;
  final String message;
  const HomeProfilePageError({
    required this.message,
    required this.title,
    required super.user,
  });
}

class HomeProfilePageLoaded extends HomeProfilePageState {
  const HomeProfilePageLoaded({required super.user});
}
