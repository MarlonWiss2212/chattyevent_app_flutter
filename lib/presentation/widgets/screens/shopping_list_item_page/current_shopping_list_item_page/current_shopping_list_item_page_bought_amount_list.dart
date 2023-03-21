import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class CurrentShoppingListItemPageBoughtAmountList extends StatelessWidget {
  const CurrentShoppingListItemPageBoughtAmountList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentShoppingListItemCubit,
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
            state.shoppingListItem.boughtAmount!.isEmpty) {
          return const Center(
            child: Text("Keine gekauften Elemente gefunden"),
          );
        }

        // optimize this later
        if (state.shoppingListItem.boughtAmount == null &&
            state.shoppingListItem.boughtAmount!.isEmpty) {
          return SkeletonListTile(
            hasSubtitle: true,
            titleStyle: const SkeletonLineStyle(width: 100, height: 22),
            subtitleStyle:
                const SkeletonLineStyle(width: double.infinity, height: 16),
            leadingStyle: const SkeletonAvatarStyle(
              shape: BoxShape.circle,
            ),
          );
        }

        return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
          builder: (context, privateEventState) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                BoughtAmountEntity boughtAmount =
                    state.shoppingListItem.boughtAmount![index];

                UserWithPrivateEventUserData? user =
                    privateEventState.privateEventUsers.firstWhereOrNull(
                  (element) => element.user.id == boughtAmount.createdBy,
                );

                final currentUser =
                    BlocProvider.of<AuthCubit>(context).state.currentUser;
                if (user == null && currentUser.id == boughtAmount.createdBy) {
                  user = UserWithPrivateEventUserData(
                    user: currentUser,
                    groupchatUser: GroupchatUserEntity(id: currentUser.id),
                    privateEventUser:
                        PrivateEventUserEntity(id: currentUser.id),
                  );
                }

                return UserListTile(
                  user: user?.user ??
                      UserEntity(
                        id: boughtAmount.createdBy ?? "",
                        authId: "",
                        username: "Fehler",
                      ),
                  customTitle: user?.getUsername(),
                  trailing: Text(
                    state.shoppingListItem.createdAt != null
                        ? DateFormat.jm()
                            .format(state.shoppingListItem.createdAt!)
                        : "Kein Datum",
                  ),
                  subtitle: Text(
                    "Eigekaufte Menge: ${boughtAmount.boughtAmount.toString()}",
                  ),
                );
              },
              itemCount: state.shoppingListItem.boughtAmount!.length,
            );
          },
        );
      },
    );
  }
}
