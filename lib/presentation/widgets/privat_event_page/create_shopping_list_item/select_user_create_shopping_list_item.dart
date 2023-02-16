import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/add_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_grid_list_item.dart';

class SelectUserCreateShoppingListItem extends StatelessWidget {
  const SelectUserCreateShoppingListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
        builder: (context, state) {
          if (state.privateEventUsers.isNotEmpty) {
            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: UserGridListItem(
                    user: state.privateEventUsers[index].user,
                    onPress: () {
                      BlocProvider.of<AddShoppingListItemCubit>(context)
                          .emitState(
                        userToBuyItemEntity: state.privateEventUsers[index],
                      );
                    },
                  ),
                );
              },
              itemCount: state.privateEventUsers.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
            );
          } else if (state.privateEventUsers.isEmpty &&
              state.loadingPrivateEvent) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return Center(
              child: PlatformTextButton(
                child: const Text(
                  "Private Event User Laden",
                ),
                onPressed: () =>
                    BlocProvider.of<CurrentPrivateEventCubit>(context)
                        .setPrivateEventUsers(),
              ),
            );
          }
        },
      ),
    );
  }
}
