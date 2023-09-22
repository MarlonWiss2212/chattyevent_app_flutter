import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:ionicons/ionicons.dart';

class ProfilePageChatOrShoppingListButton extends StatelessWidget {
  const ProfilePageChatOrShoppingListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) => p.currentUser.id != c.currentUser.id,
      builder: (context, authState) {
        return BlocBuilder<ProfilePageCubit, ProfilePageState>(
          buildWhen: (previous, current) =>
              previous.user.myUserRelationToOtherUser?.status !=
              current.user.myUserRelationToOtherUser?.status,
          builder: (context, state) {
            if (authState.currentUser.id == state.user.authId) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    AutoRouter.of(context).push(
                      const ShoppingListWrapperRoute(
                        children: [ShoppingListRoute()],
                      ),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Icon(Icons.shopping_bag),
                          const SizedBox(width: 16),
                          Hero(
                            tag: "ShoppingListTitle",
                            child: Text(
                              "general.shoppingList.title",
                              style: Theme.of(context).textTheme.labelLarge,
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            if (state.user.myUserRelationToOtherUser?.status !=
                UserRelationStatusEnum.follower) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => AutoRouter.of(context)
                    .push(ProfileChatRoute(userId: state.user.id)),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Ionicons.chatbubble),
                        const SizedBox(width: 16),
                        Text(
                          "Chat",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
