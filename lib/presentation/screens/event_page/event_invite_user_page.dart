import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';

@RoutePage()
class EventInviteUserPage extends StatefulWidget {
  const EventInviteUserPage({super.key});

  @override
  State<EventInviteUserPage> createState() => _EventInviteUserPageState();
}

class _EventInviteUserPageState extends State<EventInviteUserPage> {
  String text = "";

  Future<void> _reloadRequest(CurrentEventState state) async {
    return await BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
      search: text,
      notTheseUserIds: state.eventUsers.map((e) => e.id).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("eventPage.inviteUserPage.title").tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CurrentEventCubit, CurrentEventState>(
          buildWhen: (p, c) => p.eventUsers.length != c.eventUsers.length,
          builder: (context, state) {
            _reloadRequest(state);

            return SelectableUserGridList(
              showTextSearch: true,
              reloadRequest: ({String? text}) {
                this.text = text ?? this.text;
                _reloadRequest(state);
              },
              loadMoreRequest: ({String? text}) {
                this.text = text ?? this.text;
                BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                  loadMore: true,
                  search: text,
                  notTheseUserIds: state.eventUsers.map((e) => e.id).toList(),
                );
              },
              userButton: (user) => Button(
                color: Theme.of(context).colorScheme.primaryContainer,
                onTap: () {
                  BlocProvider.of<CurrentEventCubit>(context)
                      .addUserToEventViaApi(
                    userId: user.id,
                  );
                },
                text: "general.addText".tr(),
              ),
            );
          },
        ),
      ),
    );
  }
}
