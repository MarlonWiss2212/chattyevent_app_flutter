import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';

class PrivateEventInviteUserPage extends StatefulWidget {
  const PrivateEventInviteUserPage({super.key});

  @override
  State<PrivateEventInviteUserPage> createState() =>
      _PrivateEventInviteUserPageState();
}

class _PrivateEventInviteUserPageState
    extends State<PrivateEventInviteUserPage> {
  @override
  void initState() {
    BlocProvider.of<UserSearchCubit>(context).getUsersByPermissionViaApi(
      requesterPrivateEventAddPermission:
          RequesterPrivateEventAddPermissionEnum.add,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User zum Event hinzufügen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
          builder: (context, state) {
            return SelectableUserGridList(
              showTextSearch: true,
              reloadRequest: ({String? text}) {
                BlocProvider.of<UserSearchCubit>(context)
                    .getUsersByPermissionViaApi(
                  requesterPrivateEventAddPermission:
                      RequesterPrivateEventAddPermissionEnum.add,
                  search: text,
                );
              },
              loadMoreRequest: ({String? text}) {
                BlocProvider.of<UserSearchCubit>(context)
                    .getUsersByPermissionViaApi(
                  loadMore: true,
                  requesterPrivateEventAddPermission:
                      RequesterPrivateEventAddPermissionEnum.add,
                  search: text,
                );
              },
              userButton: (user) => Button(
                color: Theme.of(context).colorScheme.primaryContainer,
                onTap: () {
                  BlocProvider.of<CurrentPrivateEventCubit>(context)
                      .addUserToPrivateEventViaApi(
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
                  for (PrivateEventUserEntity privateEventUser
                      in state.privateEventUsers) {
                    if (privateEventUser.id == user.id) {
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
