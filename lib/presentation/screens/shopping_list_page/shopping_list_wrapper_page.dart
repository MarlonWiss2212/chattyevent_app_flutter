import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';

@RoutePage()
class ShoppingListWrapperPage extends StatelessWidget {
  const ShoppingListWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyShoppingListCubit(
        shoppingListItemUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      ),
      child: HeroControllerScope(
        controller: HeroController(),
        child: const AutoRouter(),
      ),
    );
  }
}
