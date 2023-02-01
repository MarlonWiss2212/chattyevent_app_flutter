import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/chat_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/private_event_repository_impl.dart';
import 'package:social_media_app_flutter/injection.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

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

    return BlocProvider(
      create: (context) => CurrentPrivateEventCubit(
        chatCubit: BlocProvider.of<ChatCubit>(context),
        privateEventCubit: BlocProvider.of<PrivateEventCubit>(context),
        chatUseCases: ChatUseCases(
          chatRepository: ChatRepositoryImpl(
            graphQlDatasource: graphQlDatasource,
          ),
        ),
        privateEventUseCases: PrivateEventUseCases(
          privateEventRepository: PrivateEventRepositoryImpl(
            graphQlDatasource: graphQlDatasource,
          ),
        ),
      ),
      child: Builder(builder: (context) {
        if (privateEventToSet == null) {
          BlocProvider.of<CurrentPrivateEventCubit>(context).getOnePrivateEvent(
            getOnePrivateEventFilter:
                GetOnePrivateEventFilter(id: privateEventId),
          );
        } else {
          BlocProvider.of<CurrentPrivateEventCubit>(context)
              .setCurrentPrivateEvent(
            privateEvent: privateEventToSet!,
          );
        }

        bool dataLoaded = false;

        return BlocConsumer<CurrentPrivateEventCubit, CurrentPrivateEventState>(
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

            if (state is CurrentPrivateEventErrorGroupchat) {
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
          builder: (context, state) {
            if (state is CurrentPrivateEventStateWithPrivateEvent &&
                state.privateEvent.connectedGroupchat != null &&
                dataLoaded == false) {
              BlocProvider.of<CurrentPrivateEventCubit>(context)
                  .getGroupchatViaApi();
              BlocProvider.of<UserCubit>(context).getUsersViaApi();
              dataLoaded = true;
            }

            return PlatformScaffold(
              appBar: PlatformAppBar(
                leading: const AutoLeadingButton(),
                title: Hero(
                  tag: "$privateEventId title",
                  child: Text(
                    state is CurrentPrivateEventStateWithPrivateEvent &&
                            state.privateEvent.title != null
                        ? state.privateEvent.title!
                        : "Kein Titel",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              body: state is CurrentPrivateEventLoading
                  ? Center(child: PlatformCircularProgressIndicator())
                  : state is CurrentPrivateEventStateWithPrivateEvent
                      ? Column(
                          children: [
                            if (state is CurrentPrivateEventEditing) ...{
                              const LinearProgressIndicator()
                            },
                            const Expanded(child: AutoRouter()),
                          ],
                        )
                      : const Center(
                          child: Text(
                            "Fehler beim Laden des Events mit der Id ",
                            textAlign: TextAlign.center,
                          ),
                        ),
            );
          },
        );
      }),
    );
  }
}
