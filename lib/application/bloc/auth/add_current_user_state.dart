part of 'add_current_user_cubit.dart';

enum AddCurrentUserStateStatus { initial, loading, created }

class AddCurrentUserState {
  final File? profileImage;
  final String? firstname;
  final String? lastname;
  final String? username;
  final DateTime? birthdate;

  final AddCurrentUserStateStatus status;
  final UserEntity? addedUser;

  AddCurrentUserState({
    this.status = AddCurrentUserStateStatus.initial,
    this.addedUser,
    this.birthdate,
    this.firstname,
    this.lastname,
    this.profileImage,
    this.username,
  });
}
