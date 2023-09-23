import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class CurrentShoppingListItemPageBoughtAmountList extends StatelessWidget {
  const CurrentShoppingListItemPageBoughtAmountList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentShoppingListItemCubit,
        CurrentShoppingListItemState>(
      builder: (context, state) {
        if (state.loading == false &&
            (state.shoppingListItem.boughtAmounts == null ||
                state.shoppingListItem.boughtAmounts!.isEmpty)) {
          return Center(
            child: const Text(
              "shoppingListPage.boughtAmountList.noBoughtElementsFoundText",
            ).tr(),
          );
        }

        if (state.loading == true &&
            (state.shoppingListItem.boughtAmounts == null ||
                state.shoppingListItem.boughtAmounts!.isEmpty)) {
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

        return BlocBuilder<CurrentEventCubit, CurrentEventState>(
          builder: (context, privateEventState) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                BoughtAmountEntity boughtAmount =
                    state.shoppingListItem.boughtAmounts![index];

                EventUserEntity? user =
                    privateEventState.eventUsers.firstWhereOrNull(
                  (element) => element.id == boughtAmount.createdBy,
                );

                return Slidable(
                  key: ObjectKey(
                    state.shoppingListItem.boughtAmounts![index],
                  ),
                  enabled:
                      user?.id == privateEventState.getCurrentEventUser()?.id,
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
                    trailing: state.shoppingListItem.createdAt != null
                        ? Text(
                            DateFormat.jm()
                                .format(state.shoppingListItem.createdAt!),
                          )
                        : null,
                    subtitle: const Text(
                      "shoppingListPage.boughtAmountList.itemSubtitle",
                    ).tr(args: [boughtAmount.boughtAmount.toString()]),
                  ),
                );
              },
              itemCount: state.shoppingListItem.boughtAmounts!.length,
            );
          },
        );
      },
    );
  }
}
