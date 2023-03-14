import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/follow_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_grid_list.dart';

class UserGridListWithSearchbar extends StatelessWidget {
  const UserGridListWithSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          PlatformTextFormField(
            onChanged: (text) {
              BlocProvider.of<UserSearchCubit>(context).getUsersViaApi(
                getUsersFilter: GetUsersFilter(search: text),
              );
            },
            hintText: "User Suche:",
          ),
          const SizedBox(height: 8),
          BlocBuilder<UserSearchCubit, UserSearchState>(
            builder: (context, state) {
              if (state.status == UserSearchStateStatus.loading) {
                return Expanded(
                  child: Center(child: PlatformCircularProgressIndicator()),
                );
              }
              return Expanded(
                child: UserGridList(
                  users: state.users,
                  button: (user) {
                    return FollowButton(
                      user: user,
                      onTap: () {
                        BlocProvider.of<UserSearchCubit>(context)
                            .followOrUnfollowUserViaApi(
                          user: user,
                        );
                      },
                    );
                  },
                  onPress: (user) {
                    AutoRouter.of(context).push(
                      ProfileWrapperPageRoute(
                        userId: user.id,
                        userToSet: user,
                        loadUserFromApiToo: true,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
