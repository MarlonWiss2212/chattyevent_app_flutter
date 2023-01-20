import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/edit_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';

class PrivateEventPage extends StatelessWidget {
  final String privateEventId;
  final bool loadPrivateEvent;
  const PrivateEventPage({
    @PathParam('id') required this.privateEventId,
    this.loadPrivateEvent = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (loadPrivateEvent) {
      BlocProvider.of<PrivateEventCubit>(context).getOnePrivateEvent(
        getOnePrivateEventFilter: GetOnePrivateEventFilter(id: privateEventId),
      );
    }

    var dataLoaded = false;
    return BlocBuilder<PrivateEventCubit, PrivateEventState>(
      builder: (context, state) {
        PrivateEventEntity? foundPrivateEvent;
        if (state is PrivateEventStateLoaded) {
          for (final privateEvent in state.privateEvents) {
            if (privateEvent.id == privateEventId) {
              foundPrivateEvent = privateEvent;
              break;
            }
          }
        }

        if (foundPrivateEvent != null &&
            foundPrivateEvent.connectedGroupchat != null &&
            dataLoaded == false) {
          BlocProvider.of<ChatCubit>(context).getOneChat(
            getOneGroupchatFilter: GetOneGroupchatFilter(
              id: foundPrivateEvent.connectedGroupchat!,
            ),
          );
          BlocProvider.of<UserCubit>(context).getUsers();
          dataLoaded = true;
        }

        return PlatformScaffold(
          appBar: PlatformAppBar(
            leading: const AutoLeadingButton(),
            title: Text(
              foundPrivateEvent != null && foundPrivateEvent.title != null
                  ? foundPrivateEvent.title!
                  : "Kein Titel",
            ),
          ),
          body: Column(
            children: [
              BlocBuilder<EditPrivateEventCubit, EditPrivateEventState>(
                  builder: (context, state) {
                if (state is EditPrivateEventLoading) {
                  return const LinearProgressIndicator();
                }
                return Container();
              }),
              const Expanded(child: AutoRouter()),
            ],
          ),
        );
      },
    );
  }
}
