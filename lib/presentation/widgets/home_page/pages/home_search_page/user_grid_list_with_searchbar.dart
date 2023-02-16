import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
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
              if (state is UserSearchStateLoaded) {
                return Expanded(
                  child: UserGridList(
                    users: state.users,
                    onPress: (user) {
                      BlocProvider.of<UserCubit>(context).mergeOrAdd(
                        user: user,
                      );
                      AutoRouter.of(context).push(
                        ProfilePageRoute(
                          userId: user.id,
                          userToSet: user,
                          loadUserFromApiToo: true,
                        ),
                      );
                    },
                  ),
                );
              } else if (state is UserSearchStateLoading) {
                return Expanded(
                  child: Center(child: PlatformCircularProgressIndicator()),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: PlatformTextButton(
                      child: Text(
                        state is UserSearchStateError
                            ? state.message
                            : "User laden",
                      ),
                      onPressed: () => BlocProvider.of<UserSearchCubit>(context)
                          .getUsersViaApi(),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
