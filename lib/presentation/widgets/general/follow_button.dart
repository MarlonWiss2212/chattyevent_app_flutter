import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:dartz/dartz.dart';
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
      text = "Gefolgt";
      color = Theme.of(context).colorScheme.surface;
    } else if (user.myUserRelationToOtherUser?.status ==
        UserRelationStatusEnum.requesttofollow) {
      text = "Angefragt";
      color = Theme.of(context).colorScheme.surface;
    } else if (user.myUserRelationToOtherUser?.status ==
        UserRelationStatusEnum.blocked) {
      text = "Blockiert";
      color = Theme.of(context).colorScheme.errorContainer;
    } else {
      text = "Folgen";
      color = Theme.of(context).colorScheme.primaryContainer;
    }
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: PopupMenuButton<Either<Unit, UserRelationStatusEnum>>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
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
              UserRelationStatusEnum.follower) ...{
            const PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: Right(UserRelationStatusEnum.requesttofollow),
              child: Text("Folgen"),
            ),
          },
          if (user.myUserRelationToOtherUser?.status ==
              UserRelationStatusEnum.requesttofollow) ...{
            const PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: Left(unit),
              child: Text("Anfrage zurücknehmen"),
            ),
          },
          if (user.myUserRelationToOtherUser?.status ==
              UserRelationStatusEnum.follower) ...{
            const PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: Left(unit),
              child: Text("Nicht mehr Folgen"),
            ),
          },
          if (user.myUserRelationToOtherUser?.status !=
              UserRelationStatusEnum.blocked) ...{
            const PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: Right(UserRelationStatusEnum.blocked),
              child: Text("Blockieren"),
            ),
          },
          if (user.myUserRelationToOtherUser?.status ==
              UserRelationStatusEnum.blocked) ...{
            const PopupMenuItem<Either<Unit, UserRelationStatusEnum>>(
              value: Left(unit),
              child: Text("Nicht mehr Blockieren"),
            ),
          },
        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                text,
                style: Theme.of(context).textTheme.labelMedium,
              ),
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
