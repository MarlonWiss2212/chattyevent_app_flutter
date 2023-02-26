import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class CurrentShoppingListItemPageBoughtAmountList extends StatelessWidget {
  const CurrentShoppingListItemPageBoughtAmountList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CurrentShoppingListItemCubit,
          CurrentShoppingListItemState>(
        buildWhen: (previous, current) {
          if (previous.status != current.status) {
            return true;
          }
          if (previous.shoppingListItem.boughtAmount?.length !=
              current.shoppingListItem.boughtAmount?.length) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state.shoppingListItem.boughtAmount == null &&
                  state.status != CurrentShoppingListItemStateStatus.loading ||
              state.shoppingListItem.boughtAmount!.isEmpty &&
                  state.status != CurrentShoppingListItemStateStatus.loading) {
            return const Center(
              child: Text("Keine gekauften Elemente gefunden"),
            );
          }

          if (state.shoppingListItem.boughtAmount == null &&
                  state.status == CurrentShoppingListItemStateStatus.loading ||
              state.shoppingListItem.boughtAmount!.isEmpty &&
                  state.status == CurrentShoppingListItemStateStatus.loading) {
            return SkeletonListView(
              itemBuilder: (p0, p1) {
                return SkeletonListTile(
                  hasSubtitle: true,
                  titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                  subtitleStyle: const SkeletonLineStyle(
                      width: double.infinity, height: 16),
                  leadingStyle: const SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                  ),
                );
              },
            );
          }

          return BlocBuilder<CurrentPrivateEventCubit,
              CurrentPrivateEventState>(
            builder: (context, privateEventState) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  BoughtAmountEntity boughtAmount =
                      state.shoppingListItem.boughtAmount![index];

                  UserWithPrivateEventUserData user =
                      privateEventState.privateEventUsers.firstWhere(
                    (element) => element.user.id == boughtAmount.createdBy,
                  );

                  return UserListTile(
                    username: user.getUsername(),
                    profileImageLink: user.user.profileImageLink,
                    userId: user.user.id,
                    subtitle: Text(boughtAmount.boughtAmount.toString()),
                  );
                },
                itemCount: state.shoppingListItem.boughtAmount!.length,
              );
            },
          );
        },
      ),
    );
  }
}