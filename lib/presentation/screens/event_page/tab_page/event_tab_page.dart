import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_delete_button.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class EventTabPage extends StatelessWidget {
  final String eventId;
  const EventTabPage({super.key, @PathParam('id') required this.eventId});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        const EventTabInfo(),
        if (BlocProvider.of<CurrentEventCubit>(context)
                .state
                .event
                .groupchatTo ==
            null) ...{
          EventTabChat(eventId: eventId),
        },
        const EventTabUserList(),
        const EventTabShoppingList(),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: const AutoLeadingButton(),
            title: BlocBuilder<CurrentEventCubit, CurrentEventState>(
              builder: (context, state) {
                return Hero(
                  tag: "$eventId title",
                  child: EditInputTextField(
                    text: state.event.title ?? "Kein Titel",
                    editable: state.currentUserAllowedWithPermission(
                      permissionCheckValue:
                          state.event.permissions?.changeTitle,
                    ),
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    onSaved: (text) {
                      BlocProvider.of<CurrentEventCubit>(context)
                          .updateCurrentEvent(
                        updateEventDto: UpdateEventDto(
                          title: text,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            actions: const [EventTabInfoDeleteButton()],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomTabBar(
                  controller: tabController,
                  tabs: [
                    const Tab(icon: Icon(Icons.celebration)),
                    if (BlocProvider.of<CurrentEventCubit>(context)
                            .state
                            .event
                            .groupchatTo ==
                        null) ...{
                      const Tab(icon: Icon(Ionicons.chatbubble)),
                    },
                    const Tab(icon: Icon(Icons.person)),
                    const Tab(icon: Icon(Icons.shopping_cart)),
                  ],
                ),
              ),
              BlocBuilder<CurrentEventCubit, CurrentEventState>(
                buildWhen: (previous, current) {
                  if (previous.loadingGroupchat != current.loadingGroupchat) {
                    return true;
                  }
                  if (previous.loadingEvent != current.loadingEvent) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state.loadingGroupchat || state.loadingEvent) {
                    const LinearProgressIndicator();
                  }
                  return const SizedBox();
                },
              ),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
