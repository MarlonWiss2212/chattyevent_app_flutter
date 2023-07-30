import 'package:flutter/widgets.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/standard_shopping_list_item_page/standard_shopping_list_item_change_user_page.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class PrivateEventShoppingListItemChangeUserPage extends StatelessWidget {
  const PrivateEventShoppingListItemChangeUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const StandardShoppingListItemChangeUserPage();
  }
}
