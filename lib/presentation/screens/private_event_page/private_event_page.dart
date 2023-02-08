import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/shopping_list_item_repository.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/chat_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/private_event_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/shopping_list_item_repository_impl.dart';
import 'package:social_media_app_flutter/injection.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/private_event_page_scaffold.dart';

class PrivateEventPage extends StatelessWidget {
  final String privateEventId;
  final PrivateEventEntity? privateEventToSet;
  final bool loadPrivateEventFromApiToo;

  const PrivateEventPage({
    @PathParam('id') required this.privateEventId,
    this.privateEventToSet,
    this.loadPrivateEventFromApiToo = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final client = getGraphQlClient(
      token: BlocProvider.of<AuthCubit>(context).state is AuthLoaded
          ? (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token
          : null,
    );
    GraphQlDatasource graphQlDatasource = GraphQlDatasourceImpl(client: client);

    GroupchatEntity groupchatToSet =
        BlocProvider.of<ChatCubit>(context).state.chats.firstWhere(
              (element) => element.id == privateEventToSet?.connectedGroupchat,
              orElse: () => GroupchatEntity(id: ""),
            );
    List<ShoppingListItemEntity> shoppingListItemsToSet =
        BlocProvider.of<ShoppingListCubit>(context)
            .state
            .shoppingList
            .where(
              (element) => element.privateEvent == privateEventId,
            )
            .toList();

    CurrentPrivateEventCubit currentPrivateEventCubit =
        CurrentPrivateEventCubit(
      CurrentPrivateEventInitial(
        privateEvent: privateEventToSet ?? PrivateEventEntity(id: ""),
        groupchat: groupchatToSet,
        shoppingList: shoppingListItemsToSet,
      ),
      shoppingListCubit: BlocProvider.of<ShoppingListCubit>(context),
      chatCubit: BlocProvider.of<ChatCubit>(context),
      chatUseCases: ChatUseCases(
        chatRepository: ChatRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        ),
      ),
      shoppingListItemUseCases: ShoppingListItemUseCases(
        shoppingListItemRepository: ShoppingListItemRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        ),
      ),
      privateEventCubit: BlocProvider.of<PrivateEventCubit>(context),
      privateEventUseCases: PrivateEventUseCases(
        privateEventRepository: PrivateEventRepositoryImpl(
          graphQlDatasource: graphQlDatasource,
        ),
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: currentPrivateEventCubit),
      ],
      child: Builder(
        builder: (context) {
          if (privateEventToSet == null &&
              privateEventToSet!.connectedGroupchat == null &&
              !loadPrivateEventFromApiToo) {
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .getCurrentChatViaApi(
              getOneGroupchatFilter: GetOneGroupchatFilter(
                id: privateEventToSet!.connectedGroupchat!,
              ),
            );
          } else {
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .getPrivateEventAndGroupchatFromApi(
              getOnePrivateEventFilter: GetOnePrivateEventFilter(
                id: privateEventId,
              ),
              getOneGroupchatFilter: privateEventToSet != null &&
                      privateEventToSet!.connectedGroupchat != null
                  ? GetOneGroupchatFilter(
                      id: privateEventToSet!.connectedGroupchat!,
                    )
                  : null,
            );
          }

          return BlocListener<CurrentPrivateEventCubit,
              CurrentPrivateEventState>(
            listener: (context, state) async {
              if (state is CurrentPrivateEventError) {
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
            child: PrivateEventPageScaffold(
              privateEventId: privateEventId,
            ),
          );
        },
      ),
    );
  }
}
