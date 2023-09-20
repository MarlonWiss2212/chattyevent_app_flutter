import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/add_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_grid_list_item.dart';

class CreateShoppingListItemPageSelectUserList extends StatelessWidget {
  const CreateShoppingListItemPageSelectUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<CurrentEventCubit, CurrentEventState>(
        builder: (context, state) {
          if (state.eventUsers.isNotEmpty) {
            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: UserGridListItem(
                    user: state.eventUsers[index],
                    onPress: () {
                      BlocProvider.of<AddShoppingListItemCubit>(context)
                          .emitState(
                        userToBuyItemEntity: state.eventUsers[index],
                      );
                    },
                  ),
                );
              },
              itemCount: state.eventUsers.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
            );
          } else if (state.eventUsers.isEmpty && state.loadingEvent) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return Center(
              child: PlatformTextButton(
                child: const Text(
                  "general.loadMembersText",
                ).tr(),
                onPressed: () => BlocProvider.of<CurrentEventCubit>(context)
                    .getEventUsersAndLeftUsersViaApi(),
              ),
            );
          }
        },
      ),
    );
  }
}
