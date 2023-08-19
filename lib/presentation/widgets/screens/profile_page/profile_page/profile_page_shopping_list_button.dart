import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageShoppingListButton extends StatelessWidget {
  const ProfilePageShoppingListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
      buildWhen: (p, c) => p.user.id != c.user.id,
      builder: (context, state) {
        if (state.user.authId !=
            BlocProvider.of<AuthCubit>(context).state.currentUser.authId) {
          return const SizedBox();
        }
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
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_bag),
                    const SizedBox(width: 16),
                    Hero(
                      tag: "ShoppingListTitle",
                      child: Text(
                        "Einkaufsliste",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
