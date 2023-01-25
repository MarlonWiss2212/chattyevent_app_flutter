import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

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
      BlocProvider.of<CurrentPrivateEventCubit>(context).getOnePrivateEvent(
        getOnePrivateEventFilter: GetOnePrivateEventFilter(id: privateEventId),
      );
    }

    var dataLoaded = false;

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
      },
      builder: (context, state) {
        if (state is CurrentPrivateEventStateWithPrivateEvent &&
            state.privateEvent.connectedGroupchat != null &&
            dataLoaded == false) {
          BlocProvider.of<CurrentChatCubit>(context).getOneChatViaApi(
            getOneGroupchatFilter: GetOneGroupchatFilter(
              id: state.privateEvent.connectedGroupchat!,
            ),
          );
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
                  : Center(
                      child: Text(
                        "Fehler beim Laden des Events mit der Id $privateEventId",
                        textAlign: TextAlign.center,
                      ),
                    ),
        );
      },
    );
  }
}
