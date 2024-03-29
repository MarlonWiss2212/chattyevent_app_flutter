import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/standard_shopping_list_item_page/standard_shopping_list_item_change_user_page.dart';

@RoutePage()
class ShoppingListItemChangeUserPage extends StatelessWidget {
  const ShoppingListItemChangeUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const StandardShoppingListItemChangeUserPage();
  }
}
