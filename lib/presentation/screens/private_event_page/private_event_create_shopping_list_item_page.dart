import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/button.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/create_shopping_list_item_page/create_shopping_list_item_page_detail.dart';
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
        shoppingListCubit: BlocProvider.of<MyShoppingListCubit>(context),
        shoppingListItemUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
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
                  title: Text(
                    "${state.selectedPrivateEvent?.title} neues Item",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                body: BlocListener<AddShoppingListItemCubit,
                    AddShoppingListItemState>(
                  listener: (context, state) async {
                    if (state.status == AddShoppingListItemStateStatus.error &&
                        state.error != null) {
                      return await showDialog(
                        context: context,
                        builder: (c) {
                          return CustomAlertDialog(
                            title: state.error!.title,
                            message: state.error!.message,
                            context: c,
                          );
                        },
                      );
                    } else if (state.status ==
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
                                  text: "Speichern",
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
