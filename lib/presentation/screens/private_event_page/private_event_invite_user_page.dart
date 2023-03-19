import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_grid_list.dart';

class PrivateEventInviteUserPage extends StatelessWidget {
  const PrivateEventInviteUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsersViaApi();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("User zum Event hinzufügen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            PlatformTextFormField(
              onChanged: (text) {
                BlocProvider.of<UserSearchCubit>(context).getUsersViaApi(
                  getUsersFilter: GetUsersFilter(search: text),
                );
              },
              hintText: "User Suche: ",
            ),
            const SizedBox(height: 8),
            BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
              builder: (context, currentChatState) {
                return BlocBuilder<UserSearchCubit, UserSearchState>(
                  builder: (context, state) {
                    if (state.status == UserSearchStateStatus.loading) {
                      return Expanded(
                        child: Center(
                          child: PlatformCircularProgressIndicator(),
                        ),
                      );
                    }
                    List<UserEntity> filteredUsers = [];

                    // checks if user is already in chat if not it should be visible
                    for (final user in state.users) {
                      bool pushUser = true;
                      for (PrivateEventUserEntity privateEventUser
                          in currentChatState.privateEvent.users ?? []) {
                        if (privateEventUser.userId == user.id) {
                          pushUser = false;
                          break;
                        }
                      }
                      if (pushUser) {
                        filteredUsers.add(user);
                      }
                    }

                    return Expanded(
                      child: UserGridList(
                        users: filteredUsers,
                        button: (user) => PlatformElevatedButton(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          onPressed: () {
                            BlocProvider.of<CurrentPrivateEventCubit>(context)
                                .createPrivateEventUser(
                              userId: user.id,
                            );
                          },
                          child: Text(
                            "Hinzufügen",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
