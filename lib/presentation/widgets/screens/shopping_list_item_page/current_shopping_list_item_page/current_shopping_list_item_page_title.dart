import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentShoppingListItemPageTitle extends StatelessWidget {
  const CurrentShoppingListItemPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, privateEventState) {
        return BlocBuilder<CurrentShoppingListItemCubit,
            CurrentShoppingListItemState>(
          buildWhen: (previous, current) =>
              previous.shoppingListItem.itemName !=
              current.shoppingListItem.itemName,
          builder: (context, state) => EditInputTextField(
            text: state.shoppingListItem.itemName ?? "",
            textStyle: Theme.of(context).textTheme.titleLarge?.apply(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
            editable: privateEventState.currentUserAllowedWithPermission(
              permissionCheckValue: privateEventState
                  .privateEvent.permissions?.updateShoppingListItem,
            ),
            onSaved: (text) {
              BlocProvider.of<CurrentShoppingListItemCubit>(context)
                  .updateShoppingListItemViaApi(
                updateShoppingListItemDto: UpdateShoppingListItemDto(
                  itemName: text,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
