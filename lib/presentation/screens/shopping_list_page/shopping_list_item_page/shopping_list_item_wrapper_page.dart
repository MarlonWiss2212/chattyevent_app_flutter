import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/standard_shopping_list_item_page/standard_shopping_list_item_wrapper_page.dart';

@RoutePage()
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
    CurrentEventCubit currentPrivateEventCubit = CurrentEventCubit(
      CurrentEventState.fromEvent(
        event: EventEntity(
          id: currentShoppingListItemStateToSet.shoppingListItem.eventTo ?? "",
          eventDate: DateTime.now(),
        ),
      ),
      messageStreamCubit: BlocProvider.of<MessageStreamCubit>(context),
      messageUseCases: authenticatedLocator(),
      authCubit: BlocProvider.of<AuthCubit>(context),
      locationUseCases: serviceLocator(),
      chatCubit: BlocProvider.of<ChatCubit>(context),
      requestUseCases: authenticatedLocator(),
      groupchatUseCases: authenticatedLocator(),
      notificationCubit: BlocProvider.of<NotificationCubit>(context),
      shoppingListItemUseCases: authenticatedLocator(),
      homeEventCubit: BlocProvider.of<HomeEventCubit>(context),
      eventUseCases: authenticatedLocator(),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => currentPrivateEventCubit),
      ],
      child: StandardShoppingListItemWrapperPage(
        shoppingListItemId: shoppingListItemId,
        setCurrentPrivateEvent: true,
        shoppingListItemStateToSet: currentShoppingListItemStateToSet,
      ),
    );
  }
}
