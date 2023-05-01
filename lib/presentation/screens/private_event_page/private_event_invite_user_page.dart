import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/core/filter/user/find_users_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_grid_list.dart';

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
        child: Column(
          children: [
            PlatformTextFormField(
              onChanged: (text) {
                BlocProvider.of<UserSearchCubit>(context).getUsersViaApi(
                  findUsersFilter: FindUsersFilter(search: text),
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
                    return Expanded(
                      child: UserGridList(
                        users: state.users,
                        button: (user) => PlatformElevatedButton(
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
