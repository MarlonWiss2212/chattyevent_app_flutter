part of 'current_user_cubit.dart';

@immutable
abstract class CurrentUserState {
  final UserEntity user;
  final bool loadingUser;
  const CurrentUserState({
    required this.user,
    required this.loadingUser,
  });
}

class CurrentUserNormal extends CurrentUserState {
  const CurrentUserNormal({
    required super.user,
    required super.loadingUser,
  });
}

class CurrentUserError extends CurrentUserState {
  final String title;
  final String message;
  const CurrentUserError({
    required this.message,
    required this.title,
    required super.user,
    required super.loadingUser,
  });
}
