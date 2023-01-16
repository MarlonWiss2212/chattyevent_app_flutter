//part of 'auth_bloc.dart';
part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
  final String? title;
  final String message;
  AuthStateError({required this.message, this.title});
}

class AuthStateLoaded extends AuthState {
  final String token;
  AuthStateLoaded({required this.token});
}
