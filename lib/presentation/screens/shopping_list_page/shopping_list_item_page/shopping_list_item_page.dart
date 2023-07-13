import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/standard_shopping_list_item_page/standard_shopping_list_item_page.dart';

@RoutePage()
class ShoppingListItemPage extends StatelessWidget {
  const ShoppingListItemPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const StandardShoppingListItemPage();
  }
}
