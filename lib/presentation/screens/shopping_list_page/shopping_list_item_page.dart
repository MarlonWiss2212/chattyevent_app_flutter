import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/standard_shopping_list_item_page.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

class ShoppingListItemPage extends StatelessWidget {
  final String shoppingListItemId;
  final ShoppingListItemEntity shoppingListItemToSet;
  final bool loadShoppingListItemFromApiToo;

  const ShoppingListItemPage({
    super.key,
    @PathParam('shoppingListItemId') required this.shoppingListItemId,
    required this.shoppingListItemToSet,
    this.loadShoppingListItemFromApiToo = true,
  });

  @override
  Widget build(BuildContext context) {
    CurrentPrivateEventCubit currentPrivateEventCubit =
        CurrentPrivateEventCubit(
      CurrentPrivateEventState(
        shoppingListItems: [],
        loadingShoppingList: false,
        privateEventUsers: const [],
        privateEvent: PrivateEventEntity(id: ""),
        loadingGroupchat: false,
        loadingPrivateEvent: false,
      ),
      locationUseCases: serviceLocator(),
      userCubit: BlocProvider.of<UserCubit>(context),
      chatCubit: BlocProvider.of<ChatCubit>(context),
      chatUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      shoppingListItemUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      privateEventCubit: BlocProvider.of<PrivateEventCubit>(context),
      privateEventUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: currentPrivateEventCubit),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<CurrentPrivateEventCubit,
              CurrentPrivateEventState>(
            listener: (context, state) async {
              if (state.status == CurrentPrivateEventStateStatus.error &&
                  state.error != null) {
                return await showDialog(
                  context: context,
                  builder: (c) {
                    return CustomAlertDialog(
                      message: state.error!.message,
                      title: state.error!.title,
                      context: c,
                    );
                  },
                );
              }
            },
            child: StandardShoppingListItemPage(
              setCurrentPrivateEvent: true,
              loadShoppingListItemFromApiToo: loadShoppingListItemFromApiToo,
              shoppingListItemToSet: shoppingListItemToSet,
              shoppingListItemId: shoppingListItemId,
            ),
          );
        },
      ),
    );
  }
}
