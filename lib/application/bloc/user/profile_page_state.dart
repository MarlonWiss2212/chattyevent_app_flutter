part of 'profile_page_cubit.dart';

enum ProfilePageStateStatus { initial, loading, success, error }

enum ProfilePageStateFollowersStatus { initial, loading, success, error }

enum ProfilePageStateFollowRequestsStatus { initial, loading, success, error }

enum ProfilePageStateFollowedStatus { initial, loading, success, error }

class ProfilePageState {
  final UserEntity user;
  final ProfilePageStateStatus status;
  final ErrorWithTitleAndMessage? error;

  final List<UserEntity>? followers;
  final ProfilePageStateFollowersStatus followersStatus;
  final ErrorWithTitleAndMessage? followersError;

  final List<UserEntity>? followRequests;
  final ProfilePageStateFollowRequestsStatus followRequestsStatus;
  final ErrorWithTitleAndMessage? followRequestsError;

  final List<UserEntity>? followed;
  final ProfilePageStateFollowedStatus followedStatus;
  final ErrorWithTitleAndMessage? followedError;

  const ProfilePageState({
    required this.user,
    this.status = ProfilePageStateStatus.initial,
    this.error,
    this.followers,
    this.followersStatus = ProfilePageStateFollowersStatus.initial,
    this.followersError,
    this.followRequests,
    this.followRequestsStatus = ProfilePageStateFollowRequestsStatus.initial,
    this.followRequestsError,
    this.followed,
    this.followedStatus = ProfilePageStateFollowedStatus.initial,
    this.followedError,
  });
}
