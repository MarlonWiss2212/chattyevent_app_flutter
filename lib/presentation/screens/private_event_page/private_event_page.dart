import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/current_private_event_groupchat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
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
  const PrivateEventPage({
    @PathParam('id') required this.privateEventId,
    this.privateEventToSet,
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

    CurrentPrivateEventCubit currentPrivateEventCubit =
        CurrentPrivateEventCubit(
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
        BlocProvider.value(
          value: CurrentPrivateEventGroupchatCubit(
            chatCubit: BlocProvider.of<ChatCubit>(context),
            chatUseCases: ChatUseCases(
              chatRepository:
                  ChatRepositoryImpl(graphQlDatasource: graphQlDatasource),
            ),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          if (privateEventToSet == null) {
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .getOnePrivateEvent(
              getOnePrivateEventFilter:
                  GetOnePrivateEventFilter(id: privateEventId),
            );
          } else {
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .setCurrentPrivateEvent(
              privateEvent: privateEventToSet!,
            );
          }

          return MultiBlocListener(
            listeners: [
              BlocListener<CurrentPrivateEventCubit, CurrentPrivateEventState>(
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
              }),
              BlocListener<CurrentPrivateEventGroupchatCubit,
                  CurrentPrivateEventGroupchatState>(
                listener: (context, state) async {
                  if (state is CurrentPrivateEventGroupchatError) {
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
              ),
              BlocListener<ShoppingListCubit, ShoppingListState>(
                listener: (context, state) async {
                  if (state is ShoppingListError) {
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
              ),
            ],
            child: PrivateEventPageScaffold(
              privateEventId: privateEventId,
            ),
          );
        },
      ),
    );
  }
}
