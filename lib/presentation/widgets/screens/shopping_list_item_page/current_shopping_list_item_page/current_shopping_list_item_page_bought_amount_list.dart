import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class CurrentShoppingListItemPageBoughtAmountList extends StatelessWidget {
  const CurrentShoppingListItemPageBoughtAmountList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentShoppingListItemCubit,
        CurrentShoppingListItemState>(
      builder: (context, state) {
        if (state.loadingBoughtAmounts == false &&
            state.boughtAmounts.isEmpty) {
          return const Center(
            child: Text("Keine gekauften Elemente gefunden"),
          );
        }

        if (state.loadingBoughtAmounts == true && state.boughtAmounts.isEmpty) {
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
                BoughtAmountEntity boughtAmount = state.boughtAmounts[index];

                PrivateEventUserEntity? user =
                    privateEventState.privateEventUsers.firstWhereOrNull(
                  (element) => element.id == boughtAmount.createdBy,
                );

                return Slidable(
                  enabled: user?.id ==
                      privateEventState.getCurrentPrivateEventUser()?.id,
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(8),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        foregroundColor: Colors.red,
                        onPressed: (context) {
                          BlocProvider.of<CurrentShoppingListItemCubit>(context)
                              .deleteBoughtAmount(
                            boughtAmountId: boughtAmount.id,
                          );
                        },
                        icon: Icons.delete,
                      ),
                    ],
                  ),
                  child: UserListTile(
                    user: user ??
                        UserEntity(
                          id: boughtAmount.createdBy ?? "",
                          authId: "",
                          username: "",
                        ),
                    trailing: Text(
                      state.shoppingListItem.createdAt != null
                          ? DateFormat.jm()
                              .format(state.shoppingListItem.createdAt!)
                          : "Kein Datum",
                    ),
                    subtitle: Text(
                      "Eigekaufte Menge: ${boughtAmount.boughtAmount.toString()}",
                    ),
                  ),
                );
              },
              itemCount: state.boughtAmounts.length,
            );
          },
        );
      },
    );
  }
}
