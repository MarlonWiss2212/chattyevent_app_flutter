import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/standard_shopping_list_item_page/standard_shopping_list_item_wrapper_page.dart';

class ShoppingListItemWrapperPage extends StatelessWidget {
  final String shoppingListItemId;
  final CurrentShoppingListItemState currentShoppingListItemStateToSet;

  const ShoppingListItemWrapperPage({
    super.key,
    @PathParam('shoppingListItemId') required this.shoppingListItemId,
    required this.currentShoppingListItemStateToSet,
  });

  @override
  Widget build(BuildContext context) {
    CurrentPrivateEventCubit currentPrivateEventCubit =
        CurrentPrivateEventCubit(
      CurrentPrivateEventState(
        currentUserIndex: -1,
        privateEventLeftUsers: [],
        shoppingListItemStates: [],
        loadingShoppingList: false,
        privateEventUsers: const [],
        privateEvent: PrivateEventEntity(id: ""),
        loadingGroupchat: false,
        loadingPrivateEvent: false,
      ),
      authCubit: BlocProvider.of<AuthCubit>(context),
      locationUseCases: serviceLocator(),
      userCubit: BlocProvider.of<UserCubit>(context),
      chatCubit: BlocProvider.of<ChatCubit>(context),
      chatUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      notificationCubit: BlocProvider.of<NotificationCubit>(context),
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
      child: StandardShoppingListItemWrapperPage(
        shoppingListItemId: shoppingListItemId,
        setCurrentPrivateEvent: true,
        shoppingListItemStateToSet: currentShoppingListItemStateToSet,
      ),
    );
  }
}
