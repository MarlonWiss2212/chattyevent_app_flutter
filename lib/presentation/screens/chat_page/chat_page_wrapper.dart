import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/chat_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/private_event_repository_impl.dart';
import 'package:social_media_app_flutter/injection.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class ChatPageWrapper extends StatelessWidget {
  final String groupchatId;
  final GroupchatEntity? chatToSet;
  final bool loadChatFromApiToo;

  const ChatPageWrapper({
    super.key,
    @PathParam('id') required this.groupchatId,
    this.chatToSet,
    this.loadChatFromApiToo = true,
  });

  @override
  Widget build(BuildContext context) {
    final client = getGraphQlClient(
      token: BlocProvider.of<AuthCubit>(context).state is AuthLoaded
          ? (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token
          : null,
    );

    return BlocProvider(
      create: (context) => CurrentChatCubit(
        CurrentChatNormal(
          privateEvents: const [],
          loadingPrivateEvents: false,
          usersWithGroupchatUserData: const [],
          usersWithLeftGroupchatUserData: const [],
          currentChat: chatToSet ?? GroupchatEntity(id: ""),
          loadingChat: false,
        ),
        privateEventCubit: BlocProvider.of<PrivateEventCubit>(context),
        privateEventUseCases: PrivateEventUseCases(
          privateEventRepository: PrivateEventRepositoryImpl(
            graphQlDatasource: GraphQlDatasourceImpl(
              client: client,
            ),
          ),
        ),
        userCubit: BlocProvider.of<UserCubit>(context),
        chatCubit: BlocProvider.of<ChatCubit>(context),
        chatUseCases: ChatUseCases(
          chatRepository: ChatRepositoryImpl(
            graphQlDatasource: GraphQlDatasourceImpl(client: client),
          ),
        ),
      ),
      child: BlocListener<CurrentChatCubit, CurrentChatState>(
        listener: (context, state) async {
          if (state is CurrentChatError) {
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
        child: Builder(builder: (context) {
          BlocProvider.of<CurrentChatCubit>(context).setGroupchatUsers();
          BlocProvider.of<CurrentChatCubit>(context)
              .setPrivateEventFromPrivateEventCubit();

          // too get the users from the api too
          BlocProvider.of<CurrentChatCubit>(context).getGroupchatUsersViaApi();

          if (chatToSet == null || loadChatFromApiToo) {
            BlocProvider.of<CurrentChatCubit>(context).getCurrentChatViaApi(
              getOneGroupchatFilter: GetOneGroupchatFilter(id: groupchatId),
            );
          }

          return const AutoRouter();
        }),
      ),
    );
  }
}
