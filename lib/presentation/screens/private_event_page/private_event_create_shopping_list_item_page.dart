import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/create_shopping_list_item_page/create_shopping_list_item_page_detail.dart';
import '../../../application/bloc/shopping_list/add_shopping_list_item_cubit.dart';

class PrivateEventCreateShoppingListItemPage extends StatelessWidget {
  final String privateEventId;
  const PrivateEventCreateShoppingListItemPage({
    super.key,
    @PathParam('id') required this.privateEventId,
  });

  @override
  Widget build(BuildContext context) {
    final currentPrivateEvent =
        BlocProvider.of<CurrentPrivateEventCubit>(context).state.privateEvent;

    return BlocProvider.value(
      value: AddShoppingListItemCubit(
        AddShoppingListItemState(selectedPrivateEvent: currentPrivateEvent),
        shoppingListItemUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        currentPrivateEventCubit: BlocProvider.of<CurrentPrivateEventCubit>(
          context,
        ),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<AddShoppingListItemCubit,
              AddShoppingListItemState>(
            buildWhen: (previous, current) =>
                previous.selectedPrivateEvent != current.selectedPrivateEvent,
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "${state.selectedPrivateEvent?.title} neues Item",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                body: BlocListener<AddShoppingListItemCubit,
                    AddShoppingListItemState>(
                  listener: (context, state) async {
                    if (state.status ==
                            AddShoppingListItemStateStatus.success &&
                        state.addedShoppingListItem != null) {
                      AutoRouter.of(context).pop();
                    }
                  },
                  child: Column(
                    children: [
                      BlocBuilder<AddShoppingListItemCubit,
                          AddShoppingListItemState>(
                        builder: (context, state) {
                          if (state.status ==
                              AddShoppingListItemStateStatus.loading) {
                            return const LinearProgressIndicator();
                          }
                          return Container();
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const Expanded(
                                child: CreateShoppingListItemPageDetail(),
                              ),
                              const SizedBox(height: 8.0),
                              SizedBox(
                                width: double.infinity,
                                child: Button(
                                  onTap: () async {
                                    BlocProvider.of<AddShoppingListItemCubit>(
                                            context)
                                        .createShoppingListItemViaApi();
                                  },
                                  text: "Erstellen",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
