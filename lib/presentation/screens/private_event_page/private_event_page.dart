import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

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
      BlocProvider.of<PrivateEventBloc>(context).add(
        GetOnePrivateEventEvent(
          getOnePrivateEventEvent: GetOnePrivateEventFilter(id: privateEventId),
        ),
      );
    }

    var dataLoaded = false;
    return BlocBuilder<PrivateEventBloc, PrivateEventState>(
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
          BlocProvider.of<ChatBloc>(context).add(
            GetOneChatEvent(
              getOneGroupchatFilter: GetOneGroupchatFilter(
                id: foundPrivateEvent.connectedGroupchat!,
              ),
            ),
          );
          BlocProvider.of<MessageBloc>(context).add(
            GetMessagesEvent(
              getMessagesFilter: GetMessagesFilter(
                groupchatTo: foundPrivateEvent.connectedGroupchat!,
              ),
            ),
          );
          BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
          dataLoaded = true;
        }

        return AutoTabsRouter.tabBar(
          routes: [
            InfoTabRoute(),
            GroupchatTabRoute(),
          ],
          builder: (context, child, tabController) {
            return PlatformScaffold(
              appBar: PlatformAppBar(
                leading: const AutoLeadingButton(),
                title: Text(
                  foundPrivateEvent != null && foundPrivateEvent.title != null
                      ? foundPrivateEvent.title!
                      : "Kein Titel",
                ),
                material: (context, platform) => MaterialAppBarData(
                  bottom: TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(icon: Icon(Icons.event)),
                      Tab(icon: Icon(Icons.chat_bubble)),
                    ],
                  ),
                ),
                cupertino: (context, platform) => CupertinoNavigationBarData(),
              ),
              body: child,
            );
          },
        );
      },
    );
  }
}
