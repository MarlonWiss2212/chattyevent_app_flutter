import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/shopping_list/current_private_event_shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_shopping_list_items_filter.dart';

class ShoppingListTab extends StatelessWidget {
  final String privateEventId;
  const ShoppingListTab({
    @PathParam('id') required this.privateEventId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentPrivateEventShoppingListCubit>(context)
        .getShoppingListViaApi(
      getShoppingListItemsFilter:
          GetShoppingListItemsFilter(privateEvent: privateEventId),
    );

    return BlocBuilder<CurrentPrivateEventShoppingListCubit,
        CurrentPrivateEventShoppingListState>(
      builder: (context, state) {
        if (state is CurrentPrivateEventShoppingListStateWithShoppingList) {
          if (state.shoppingList.isEmpty) {
            return const Center(
              child: Text("Keine Items die gekauft werden müssen"),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  state.shoppingList[index]["itemName"],
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  "${state.shoppingList[index]['amount']} ${state.shoppingList[index]['unit']}",
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {},
              );
            },
            itemCount: state.shoppingList.length,
          );
        } else if (state is CurrentPrivateEventShoppingListLoading) {
          return SkeletonListView(
            itemBuilder: (p0, p1) {
              return SkeletonListTile(
                hasSubtitle: true,
                hasLeading: false,
                titleStyle: const SkeletonLineStyle(
                  width: double.infinity,
                  height: 22,
                ),
                subtitleStyle: const SkeletonLineStyle(
                  width: double.infinity,
                  height: 16,
                ),
              );
            },
          );
        } else {
          return Center(
            child: PlatformTextButton(
              child: Text(
                state is CurrentPrivateEventShoppingListError
                    ? state.message
                    : "Fehler beim Laden der Einkaufsliste des Events",
              ),
              onPressed: () =>
                  BlocProvider.of<CurrentPrivateEventShoppingListCubit>(context)
                      .getShoppingListViaApi(
                getShoppingListItemsFilter:
                    GetShoppingListItemsFilter(privateEvent: privateEventId),
              ),
            ),
          );
        }
      },
    );
  }
}
