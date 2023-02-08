import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/add_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/create_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class AddShoppingListItem extends StatelessWidget {
  final String privateEventId;
  const AddShoppingListItem({super.key, required this.privateEventId});

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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      SizedBox(
                        width: double.infinity,
                        child: PlatformTextFormField(
                          hintText: "Item name",
                        ),
                      ),
                      // Row(
                      //    children: const [
                      //        SizedBox(
                      //        width: double.infinity,
                      //                       child: PlatformTextFormField(
                      //                       hintText: "Menge",
                      //                   ),
                      //               ),
                      //             SizedBox(
                      //             width: 100,
                      //           child: PlatformTextFormField(
                      //           hintText: "Einheit",
                      //       ),
                      //   ),
                      //],
                      //),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              BlocListener<AddShoppingListItemCubit, AddShoppingListItemState>(
                listener: (context, state) {
                  if (state is AddShoppingListItemLoaded) {
                    BlocProvider.of<CurrentPrivateEventCubit>(context).addItem(
                      shoppingListItem: state.addedShoppingListItem,
                    );
                    BlocProvider.of<ShoppingListCubit>(context).addItem(
                      shoppingListItem: state.addedShoppingListItem,
                    );
                    Navigator.pop(context);
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: PlatformElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AddShoppingListItemCubit>(context)
                          .createShoppingListItem(
                        createShoppingListItemDto: CreateShoppingListItemDto(
                          userToBuyItem: Jwt.parseJwt(
                              (BlocProvider.of<AuthCubit>(context).state
                                      as AuthLoaded)
                                  .token)["sub"],
                          amount: 1.0,
                          itemName: "weed",
                          unit: "g",
                          privateEvent: privateEventId,
                        ),
                      );
                    },
                    child: const Text("Speichern"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
