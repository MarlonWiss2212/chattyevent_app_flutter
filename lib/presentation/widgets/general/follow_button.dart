import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:ionicons/ionicons.dart';

class FollowButton extends StatelessWidget {
  final UserEntity user;
  final void Function(UserRelationStatusEnum? value)? onTap;

  const FollowButton({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (user.id == BlocProvider.of<AuthCubit>(context).state.currentUser.id) {
      return const SizedBox();
    }

    String text = "";
    Color? color;

    if (user.myUserRelationToOtherUser?.status ==
        UserRelationStatusEnum.follower) {
      text = "general.followButton.followedText";
      color = Theme.of(context).colorScheme.surface;
    } else if (user.myUserRelationToOtherUser?.status ==
        UserRelationStatusEnum.requesttofollow) {
      text = "general.followButton.requestedText";
      color = Theme.of(context).colorScheme.surface;
    } else if (user.myUserRelationToOtherUser?.status ==
        UserRelationStatusEnum.blocked) {
      text = "general.followButton.blockedText";
      color = Theme.of(context).colorScheme.errorContainer;
    } else {
      text = "general.followButton.followText";
      color = Theme.of(context).colorScheme.primaryContainer;
    }
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: PopupMenuButton<Either<Unit, UserRelationStatusEnum>>(
        initialValue: user.myUserRelationToOtherUser?.status != null
            ? Right(user.myUserRelationToOtherUser!.status!)
            : const Left(unit),
        onSelected: onTap != null
            ? (value) {
                value.fold((l) => onTap!(null), (r) => onTap!(r));
              }
            : null,
        itemBuilder: (context) => [
          if (user.myUserRelationToOtherUser?.status !=
                  UserRelationStatusEnum.follower &&
              user.myUserRelationToOtherUser?.status !=
                  UserRelationStatusEnum.requesttofollow) ...{
            PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: const Right(UserRelationStatusEnum.requesttofollow),
              child: const Text("general.followButton.followText").tr(),
            ),
          },
          if (user.myUserRelationToOtherUser?.status ==
              UserRelationStatusEnum.requesttofollow) ...{
            PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: const Left(unit),
              child: const Text("general.followButton.takeBackRequest").tr(),
            ),
          },
          if (user.myUserRelationToOtherUser?.status ==
              UserRelationStatusEnum.follower) ...{
            PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: const Left(unit),
              child: const Text(
                "general.followButton.dontFollowAnymoreText",
              ).tr(),
            ),
          },
          if (user.myUserRelationToOtherUser?.status !=
              UserRelationStatusEnum.blocked) ...{
            PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: const Right(UserRelationStatusEnum.blocked),
              child: const Text("general.followButton.blockText").tr(),
            ),
          },
          if (user.myUserRelationToOtherUser?.status ==
              UserRelationStatusEnum.blocked) ...{
            PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: const Left(unit),
              child: const Text(
                "general.followButton.dontBlockAnymoreText",
              ).tr(),
            ),
          },
        ],
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                text,
                style: Theme.of(context).textTheme.labelMedium,
              ).tr(),
              const Icon(
                Ionicons.arrow_down,
                size: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
