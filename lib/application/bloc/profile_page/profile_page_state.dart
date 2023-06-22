part of 'profile_page_cubit.dart';

enum ProfilePageStateStatus { initial, loading, success }

enum ProfilePageStateFollowersStatus { initial, loading, success }

enum ProfilePageStateFollowRequestsStatus { initial, loading, success }

enum ProfilePageStateFollowedStatus { initial, loading, success }

class ProfilePageState {
  final UserEntity user;
  final ProfilePageStateStatus status;

  final List<MessageEntity> messages;
  final bool loadingMessages;

  final List<UserEntity> followers;
  final ProfilePageStateFollowersStatus followersStatus;

  final List<UserEntity> followRequests;
  final ProfilePageStateFollowRequestsStatus followRequestsStatus;

  final List<UserEntity> followed;
  final ProfilePageStateFollowedStatus followedStatus;

  const ProfilePageState({
    required this.user,
    required this.messages,
    required this.loadingMessages,
    this.status = ProfilePageStateStatus.initial,
    required this.followers,
    this.followersStatus = ProfilePageStateFollowersStatus.initial,
    required this.followRequests,
    this.followRequestsStatus = ProfilePageStateFollowRequestsStatus.initial,
    required this.followed,
    this.followedStatus = ProfilePageStateFollowedStatus.initial,
  });

  factory ProfilePageState.fromUser({required UserEntity user}) {
    return ProfilePageState(
      user: user,
      messages: [],
      loadingMessages: false,
      followers: [],
      followRequests: [],
      followed: [],
    );
  }
}
