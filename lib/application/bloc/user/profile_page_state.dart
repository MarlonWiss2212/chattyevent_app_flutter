part of 'profile_page_cubit.dart';

enum ProfilePageStateStatus { initial, loading, success }

enum ProfilePageStateFollowersStatus { initial, loading, success }

enum ProfilePageStateFollowRequestsStatus { initial, loading, success }

enum ProfilePageStateFollowedStatus { initial, loading, success }

class ProfilePageState {
  final UserEntity user;
  final ProfilePageStateStatus status;

  final List<UserEntity>? followers;
  final ProfilePageStateFollowersStatus followersStatus;
  final ErrorWithTitleAndMessage? followersError;

  final List<UserEntity>? followRequests;
  final ProfilePageStateFollowRequestsStatus followRequestsStatus;

  final List<UserEntity>? followed;
  final ProfilePageStateFollowedStatus followedStatus;

  const ProfilePageState({
    required this.user,
    this.status = ProfilePageStateStatus.initial,
    this.followers,
    this.followersStatus = ProfilePageStateFollowersStatus.initial,
    this.followersError,
    this.followRequests,
    this.followRequestsStatus = ProfilePageStateFollowRequestsStatus.initial,
    this.followed,
    this.followedStatus = ProfilePageStateFollowedStatus.initial,
  });
}
