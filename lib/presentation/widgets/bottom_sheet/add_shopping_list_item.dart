import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/add_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class AddShoppingListItem extends StatelessWidget {
  const AddShoppingListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddShoppingListItemCubit, AddShoppingListItemState>(
      listener: (context, state) async {
        if (state is AddShoppingListItemError) {
          return await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text(state.title),
                content: Text(state.message),
                actions: const [OKButton()],
              );
            },
          );
        }
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: const [
              // add elements
            ],
          ),
        ),
      ),
    );
  }
}
