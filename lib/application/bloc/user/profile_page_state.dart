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
  final int followersOffset;

  final List<UserEntity>? followRequests;
  final ProfilePageStateFollowRequestsStatus followRequestsStatus;
  final ErrorWithTitleAndMessage? followRequestsError;
  final int followRequestsOffset;

  final List<UserEntity>? followed;
  final ProfilePageStateFollowedStatus followedStatus;
  final ErrorWithTitleAndMessage? followedError;
  final int followedOffset;

  const ProfilePageState({
    required this.user,
    this.status = ProfilePageStateStatus.initial,
    this.error,
    this.followers,
    this.followersStatus = ProfilePageStateFollowersStatus.initial,
    this.followersError,
    required this.followersOffset,
    this.followRequests,
    this.followRequestsStatus = ProfilePageStateFollowRequestsStatus.initial,
    this.followRequestsError,
    required this.followRequestsOffset,
    this.followed,
    this.followedStatus = ProfilePageStateFollowedStatus.initial,
    this.followedError,
    required this.followedOffset,
  });
}
