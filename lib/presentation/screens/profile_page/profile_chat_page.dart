import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_chat_page/profile_chat_page_message_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:ionicons/ionicons.dart';

@RoutePage()
class ProfileChatPage extends StatefulWidget {
  const ProfileChatPage({
    @PathParam('id') required this.userId,
    super.key,
  });
  final String userId;

  @override
  State<ProfileChatPage> createState() => _ProfileChatPageState();
}

class _ProfileChatPageState extends State<ProfileChatPage> {
  @override
  void initState() {
    BlocProvider.of<ProfilePageCubit>(context).loadMessages(reload: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const AutoLeadingButton(),
        title: BlocBuilder<ProfilePageCubit, ProfilePageState>(
          buildWhen: (p, c) =>
              p.user.profileImageLink != c.user.profileImageLink ||
              p.user.username != c.user.username,
          builder: (context, state) {
            return Center(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: state.user.profileImageLink != null
                        ? CachedNetworkImageProvider(
                            state.user.profileImageLink!,
                            cacheKey:
                                state.user.profileImageLink!.split("?")[0],
                          )
                        : null,
                    backgroundColor: state.user.profileImageLink != null
                        ? null
                        : Theme.of(context).colorScheme.surface,
                  ),
                  const SizedBox(width: 8),
                  Hero(
                    tag: "${widget.userId} username",
                    child: Text(
                      state.user.username ?? "",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Ionicons.ellipsis_vertical),
            onPressed: () => AutoRouter.of(context).push(ProfileRoute()),
          )
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ProfilePageCubit, ProfilePageState>(
            buildWhen: (p, c) => p.loadingMessages != c.loadingMessages,
            builder: (context, state) {
              if (state.loadingMessages) {
                return const LinearProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          BlocBuilder<ProfilePageCubit, ProfilePageState>(
            builder: (context, state) {
              if (state.user.authId !=
                      BlocProvider.of<AuthCubit>(context)
                          .state
                          .currentUser
                          .authId &&
                  state.user.otherUserRelationToMyUser?.status !=
                      UserRelationStatusEnum.follower) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.errorContainer,
                    leading: const Icon(Icons.info),
                    title: Text(
                      "Der andere User kann dir keine Nachricht schreiben, da er dir nicht folgt, wenn du mit ihm schreiben willst, schau bitte nach, ob er dir eine Freundschaftsanfrage gesendet hat. Der andere User kann aber deine Nachricht lesen",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => AddMessageCubit(
                AddMessageState(userTo: widget.userId),
                microphoneUseCases: serviceLocator(),
                vibrationUseCases: serviceLocator(),
                imagePickerUseCases: serviceLocator(),
                locationUseCases: serviceLocator(),
                notificationCubit: BlocProvider.of<NotificationCubit>(context),
                cubitToAddMessageTo: dz.Right(
                  BlocProvider.of<ProfilePageCubit>(context),
                ),
                messageUseCases: authenticatedLocator(),
              ),
              child: const Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ProfileChatPageMessageArea(),
                  ),
                  ChatMessageInput(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
