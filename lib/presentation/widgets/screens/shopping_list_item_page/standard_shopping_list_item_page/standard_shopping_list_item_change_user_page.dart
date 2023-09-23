import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_grid_list.dart';

class StandardShoppingListItemChangeUserPage extends StatelessWidget {
  const StandardShoppingListItemChangeUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("shoppingListPage.changeUserText").tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CurrentEventCubit, CurrentEventState>(
          builder: (context, state) {
            return UserGridList(
              users: state.eventUsers,
              onPress: (user) {
                BlocProvider.of<CurrentShoppingListItemCubit>(context)
                    .updateShoppingListItemViaApi(
                      updateShoppingListItemDto: UpdateShoppingListItemDto(
                        userToBuyItem: user.id,
                      ),
                    )
                    .then(
                      (value) => AutoRouter.of(context).pop(),
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
