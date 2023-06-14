import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user/private_event_user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_delete_button.dart';

class PrivateEventTabPage extends StatelessWidget {
  final String privateEventId;
  const PrivateEventTabPage({
    super.key,
    @PathParam('id') required this.privateEventId,
  });

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        PrivateEventTabInfoRoute(),
        const PrivateEventTabUserListRoute(),
        PrivateEventTabShoppingListRoute(),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: const AutoLeadingButton(),
            title:
                BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
              builder: (context, state) {
                return Hero(
                  tag: "$privateEventId title",
                  child: EditInputTextField(
                    text: state.privateEvent.title ?? "Kein Titel",
                    editable: state.getCurrentPrivateEventUser()?.role ==
                        PrivateEventUserRoleEnum.organizer,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    onSaved: (text) {
                      BlocProvider.of<CurrentPrivateEventCubit>(context)
                          .updateCurrentPrivateEvent(
                        updatePrivateEventDto: UpdatePrivateEventDto(
                          title: text,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            actions: const [PrivateEventTabInfoDeleteButton()],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(icon: Icon(Icons.celebration)),
                      Tab(icon: Icon(Icons.person)),
                      Tab(icon: Icon(Icons.shopping_cart)),
                    ],
                  ),
                ),
              ),
              BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
                buildWhen: (previous, current) {
                  if (previous.loadingGroupchat != current.loadingGroupchat) {
                    return true;
                  }
                  if (previous.loadingPrivateEvent !=
                      current.loadingPrivateEvent) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state.loadingGroupchat || state.loadingPrivateEvent) {
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
