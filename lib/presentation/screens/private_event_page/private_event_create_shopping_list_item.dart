import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/shopping_list_item_repository_impl.dart';
import 'package:social_media_app_flutter/injection.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/create_shopping_list_item/create_shopping_list_item_detail_tab.dart';
import '../../../application/bloc/shopping_list/add_shopping_list_item_cubit.dart';

class PrivateEventCreateShoppingListItem extends StatefulWidget {
  final String privateEventId;
  const PrivateEventCreateShoppingListItem({
    super.key,
    @PathParam('id') required this.privateEventId,
  });

  @override
  State<PrivateEventCreateShoppingListItem> createState() =>
      _PrivateEventCreateShoppingListItemState();
}

class _PrivateEventCreateShoppingListItemState
    extends State<PrivateEventCreateShoppingListItem> {
  @override
  Widget build(BuildContext context) {
    final client = getGraphQlClient(
      token: BlocProvider.of<AuthCubit>(context).state is AuthLoaded
          ? (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token
          : null,
    );
    GraphQlDatasource graphQlDatasource = GraphQlDatasourceImpl(client: client);

    final currentPrivateEventCubit =
        BlocProvider.of<CurrentPrivateEventCubit>(context);

    final addShoppingListItemCubit = AddShoppingListItemCubit(
      AddShoppingListItemState(
        selectedPrivateEvent: currentPrivateEventCubit.state.privateEvent,
      ),
      currentPrivateEventCubit: currentPrivateEventCubit,
      shoppingListCubit: BlocProvider.of<ShoppingListCubit>(context),
      shoppingListItemUseCases: ShoppingListItemUseCases(
        shoppingListItemRepository: ShoppingListItemRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        ),
      ),
    );

    return BlocProvider.value(
      value: addShoppingListItemCubit,
      child: Builder(
        builder: (context) {
          return BlocBuilder<AddShoppingListItemCubit,
              AddShoppingListItemState>(
            buildWhen: (previous, current) =>
                previous.selectedPrivateEvent != current.selectedPrivateEvent,
            builder: (context, state) {
              return PlatformScaffold(
                appBar: PlatformAppBar(
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
                      return await showPlatformDialog(
                        context: context,
                        builder: (context) {
                          return PlatformAlertDialog(
                            title: Text(state.error!.title),
                            content: Text(state.error!.message),
                            actions: const [OKButton()],
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
                                child: CreateShoppingListItemDetailTab(),
                              ),
                              const SizedBox(height: 8.0),
                              SizedBox(
                                width: double.infinity,
                                child: PlatformElevatedButton(
                                  onPressed: () async {
                                    BlocProvider.of<AddShoppingListItemCubit>(
                                            context)
                                        .createShoppingListItemViaApi();
                                  },
                                  child: const Text("Speichern"),
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
