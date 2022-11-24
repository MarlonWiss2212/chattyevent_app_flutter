part of 'user_profile_bloc.dart';

@immutable
abstract class UserProfileEvent {}

class UserProfileRequestEvent extends UserProfileEvent {
  final String? userId;
  final String? email;
  UserProfileRequestEvent({this.userId, this.email});
}
