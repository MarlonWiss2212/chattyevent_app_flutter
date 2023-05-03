import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';

class PrivateEventInviteUserPage extends StatelessWidget {
  const PrivateEventInviteUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsersViaApi();

    return Scaffold(
      appBar: AppBar(
        title: const Text("User zum Event hinzufügen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
          builder: (context, state) {
            return SelectableUserGridList(
              showTextSearch: false,
              reloadRequest: ({String? text}) {
                BlocProvider.of<UserSearchCubit>(context)
                    .getUsersByPermissionViaApi(
                  followedToPrivateEventPermission: "ADD",
                );
              },
              loadMoreRequest: ({String? text}) {
                BlocProvider.of<UserSearchCubit>(context)
                    .getUsersByPermissionViaApi(
                  loadMore: true,
                  followedToPrivateEventPermission: "ADD",
                );
              },
              userButton: (user) => PlatformElevatedButton(
                color: Theme.of(context).colorScheme.primaryContainer,
                onPressed: () {
                  BlocProvider.of<CurrentPrivateEventCubit>(context)
                      .addUserToPrivateEventViaApi(
                    userId: user.id,
                  );
                },
                child: Text(
                  "Hinzufügen",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
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
