import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_area.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:ionicons/ionicons.dart';

@RoutePage()
class GroupchatPage extends StatefulWidget {
  const GroupchatPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  State<GroupchatPage> createState() => _GroupchatPageState();
}

class _GroupchatPageState extends State<GroupchatPage> {
  @override
  void initState() {
    BlocProvider.of<CurrentGroupchatCubit>(context).loadMessages(reload: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const AutoLeadingButton(),
        title: BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
          builder: (context, state) {
            return Center(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: state.currentChat.profileImageLink != null
                        ? NetworkImage(state.currentChat.profileImageLink!)
                        : null,
                    backgroundColor: state.currentChat.profileImageLink != null
                        ? null
                        : Theme.of(context).colorScheme.surface,
                  ),
                  const SizedBox(width: 8),
                  Hero(
                    tag: "${widget.groupchatId} title",
                    child: Text(
                      state.currentChat.title ?? "",
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
            icon: const Icon(Ionicons.ellipsis_vertical),
            onPressed: () => AutoRouter.of(context).push(
              GroupchatInfoRoute(groupchatId: widget.groupchatId),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
            builder: (context, state) {
              if (state.loadingChat || state.loadingMessages) {
                return const LinearProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => AddMessageCubit(
                AddMessageState(groupchatTo: widget.groupchatId),
                imagePickerUseCases: serviceLocator(),
                locationUseCases: serviceLocator(),
                vibrationUseCases: serviceLocator(),
                notificationCubit: BlocProvider.of<NotificationCubit>(context),
                cubitToAddMessageTo: dz.Left(dz.Right(
                  BlocProvider.of<CurrentGroupchatCubit>(context),
                )),
                messageUseCases: serviceLocator(
                  param1: BlocProvider.of<AuthCubit>(context).state,
                ),
              ),
              child: const Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChatPageMessageArea(),
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