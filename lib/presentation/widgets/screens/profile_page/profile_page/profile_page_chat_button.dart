import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:ionicons/ionicons.dart';

class ProfilePageChatButton extends StatelessWidget {
  const ProfilePageChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ProfilePageCubit, ProfilePageState>(
        buildWhen: (previous, current) =>
            previous.user.myUserRelationToOtherUser?.statusOnRelatedUser !=
            current.user.myUserRelationToOtherUser?.statusOnRelatedUser,
        builder: (context, state) {
          if (state.user.myUserRelationToOtherUser?.statusOnRelatedUser !=
              UserRelationStatusEnum.follower) {
            return const SizedBox();
          }
          return InkWell(
            onTap: () => AutoRouter.of(context).push(ProfileChatPageRoute()),
            borderRadius: BorderRadius.circular(8),
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Ionicons.chatbubble),
                  const SizedBox(width: 32),
                  Text("Chat", style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
