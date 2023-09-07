import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';

@RoutePage()
class EventInviteUserPage extends StatefulWidget {
  const EventInviteUserPage({super.key});

  @override
  State<EventInviteUserPage> createState() => _EventInviteUserPageState();
}

class _EventInviteUserPageState extends State<EventInviteUserPage> {
  @override
  void initState() {
    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User zum Event hinzufügen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CurrentEventCubit, CurrentEventState>(
          builder: (context, state) {
            return SelectableUserGridList(
              showTextSearch: true,
              reloadRequest: ({String? text}) {
                BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                  search: text,
                );
              },
              loadMoreRequest: ({String? text}) {
                BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                  loadMore: true,
                  search: text,
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
                text: "Hinzufügen",
              ),
              filterUsers: (users) {
                List<UserEntity> filteredUsers = [];

                // checks if user is already in chat if not it should be visible
                for (final user in users) {
                  bool pushUser = true;
                  for (EventUserEntity eventUser in state.eventUsers) {
                    if (eventUser.id == user.id) {
                      pushUser = false;
                      break;
                    }
                  }
                  if (pushUser) {
                    filteredUsers.add(user);
                  }
                }
                return filteredUsers;
              },
            );
          },
        ),
      ),
    );
  }
}
