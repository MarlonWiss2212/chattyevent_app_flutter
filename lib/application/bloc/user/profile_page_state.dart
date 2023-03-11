part of 'profile_page_cubit.dart';

enum ProfilePageStateStatus { initial, loading, success, error }

enum ProfilePageStateUserRelationStatus { initial, loading, success, error }

class ProfilePageState {
  final UserEntity user;
  final ProfilePageStateStatus status;
  final ErrorWithTitleAndMessage? error;

  /// optimze this later with skip and offset and so on
  final List<UserRelationEntity>? userRelations;
  final ProfilePageStateUserRelationStatus userRelationStatus;
  final ErrorWithTitleAndMessage? errorRelationError;

  const ProfilePageState({
    required this.user,
    this.userRelationStatus = ProfilePageStateUserRelationStatus.initial,
    this.userRelations,
    this.error,
    this.errorRelationError,
    this.status = ProfilePageStateStatus.initial,
  });
}
