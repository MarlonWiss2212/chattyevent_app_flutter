import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/profile_page/profile_chat_page/profile_chat_page_message_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:dartz/dartz.dart' as dz;

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
    BlocProvider.of<ProfilePageCubit>(context).listenToMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const AutoLeadingButton(),
        title: BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            return Center(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: state.user.profileImageLink != null
                        ? NetworkImage(state.user.profileImageLink!)
                        : null,
                    backgroundColor: state.user.profileImageLink != null
                        ? null
                        : Theme.of(context).colorScheme.secondaryContainer,
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
          PlatformIconButton(
            icon: const Icon(Icons.info),
            onPressed: () => AutoRouter.of(context).push(ProfilePageRoute()),
          )
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ProfilePageCubit, ProfilePageState>(
            builder: (context, state) {
              if (state.loadingMessages) {
                return const LinearProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          Expanded(
            child: BlocProvider.value(
              value: AddMessageCubit(
                AddMessageState(userTo: widget.userId),
                imagePickerUseCases: serviceLocator(),
                notificationCubit: BlocProvider.of<NotificationCubit>(context),
                cubitToAddMessageTo: dz.Right(
                  BlocProvider.of<ProfilePageCubit>(context),
                ),
                messageUseCases: serviceLocator(
                  param1: BlocProvider.of<AuthCubit>(context).state,
                ),
              ),
              child: const Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: ProfileChatPageMessageArea(),
                    ),
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