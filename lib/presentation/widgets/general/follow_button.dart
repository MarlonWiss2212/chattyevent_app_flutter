import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';

class FollowButton extends StatelessWidget {
  final UserEntity user;
  final void Function()? onTap;
  const FollowButton({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (user.id == BlocProvider.of<AuthCubit>(context).state.currentUser.id) {
      return const SizedBox();
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        child:
            user.myUserRelationToTheUser?.statusOnRelatedUser == "follower" ||
                    user.myUserRelationToTheUser?.statusOnRelatedUser ==
                        "requestToFollow"
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Center(
                      child: Text(
                        user.myUserRelationToTheUser?.statusOnRelatedUser ==
                                "requestToFollow"
                            ? "Angefragt"
                            : "Entfernen",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.apply(color: Colors.white),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        "Folgen",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.apply(color: Colors.white),
                      ),
                    ),
                  ),
      ),
    );
  }
}
