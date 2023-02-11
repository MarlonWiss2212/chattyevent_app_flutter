import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/shopping_list_item/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/shopping_list_item_repository_impl.dart';
import 'package:social_media_app_flutter/injection.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/create_shopping_list_item/select_user_create_shopping_list_item.dart';

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
  TextEditingController amountController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  PrivateEventUser? privateEventUser;

  @override
  Widget build(BuildContext context) {
    final client = getGraphQlClient(
      token: BlocProvider.of<AuthCubit>(context).state is AuthLoaded
          ? (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token
          : null,
    );
    GraphQlDatasource graphQlDatasource = GraphQlDatasourceImpl(client: client);
    final addShoppingListItemCubit = AddShoppingListItemCubit(
      currentPrivateEventCubit:
          BlocProvider.of<CurrentPrivateEventCubit>(context),
      shoppingListCubit: BlocProvider.of<ShoppingListCubit>(context),
      shoppingListItemUseCases: ShoppingListItemUseCases(
        shoppingListItemRepository: ShoppingListItemRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        ),
      ),
    );

    return BlocProvider.value(
      value: addShoppingListItemCubit,
      child: Builder(builder: (context) {
        return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
          builder: (context, state) {
            return PlatformScaffold(
              appBar: PlatformAppBar(
                title: Text(
                  "${state.privateEvent.title} neues Item",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: BlocListener<AddShoppingListItemCubit,
                  AddShoppingListItemState>(
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
                  } else if (state is AddShoppingListItemLoaded) {
                    AutoRouter.of(context).pop();
                  }
                },
                child: Column(
                  children: [
                    BlocBuilder<AddShoppingListItemCubit,
                        AddShoppingListItemState>(
                      builder: (context, state) {
                        if (state is AddShoppingListItemLoading) {
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
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: PlatformTextFormField(
                                        controller: itemNameController,
                                        hintText: "Item name",
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: PlatformTextFormField(
                                              controller: amountController,
                                              hintText: "Menge",
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          SizedBox(
                                            width: 100,
                                            child: PlatformTextFormField(
                                              controller: unitController,
                                              hintText: "Einheit",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Text(
                                          "User der das Item kauft: ${privateEventUser != null ? privateEventUser!.username : ''}",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ],
                                    ),
                                    SelectUserCreateShoppingListItem(
                                      newUserSelected: (newprivateEventUser) {
                                        setState(() {
                                          privateEventUser =
                                              newprivateEventUser;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            SizedBox(
                              width: double.infinity,
                              child: PlatformElevatedButton(
                                onPressed: () async {
                                  if (privateEventUser == null) {
                                    return await showPlatformDialog(
                                      context: context,
                                      builder: (context) {
                                        return PlatformAlertDialog(
                                          title: const Text("User Fehler"),
                                          content: const Text(
                                            "Du musst das Item einen User zuweisen der es kaufen soll",
                                          ),
                                          actions: const [OKButton()],
                                        );
                                      },
                                    );
                                  }

                                  final amountAsDouble = double.tryParse(
                                    amountController.text,
                                  );

                                  if (amountAsDouble == null) {
                                    return await showPlatformDialog(
                                      context: context,
                                      builder: (context) {
                                        return PlatformAlertDialog(
                                          title: const Text("Amount Fehler"),
                                          content: const Text(
                                              "Amount muss eine Zahl sein"),
                                          actions: const [OKButton()],
                                        );
                                      },
                                    );
                                  }

                                  BlocProvider.of<AddShoppingListItemCubit>(
                                          context)
                                      .createShoppingListItem(
                                    createShoppingListItemDto:
                                        CreateShoppingListItemDto(
                                      userToBuyItem: privateEventUser!.id,
                                      amount: amountAsDouble,
                                      itemName: itemNameController.text,
                                      unit: unitController.text,
                                      privateEventId: widget.privateEventId,
                                    ),
                                  );
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
      }),
    );
  }
}
