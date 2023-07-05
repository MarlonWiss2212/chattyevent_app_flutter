import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class PrivateEventAddMePageUserList extends StatelessWidget {
  const PrivateEventAddMePageUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<UserSearchCubit, UserSearchState>(
        builder: (context, state) {
          if (state.users.isEmpty) {
            return const Center(child: Text("Keine User"));
          }
          if (state.status == UserSearchStateStatus.loading) {
            return SkeletonListView(
              spacing: 0,
              itemBuilder: (p0, p1) {
                return SkeletonListTile(
                  hasSubtitle: true,
                  titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                  subtitleStyle: const SkeletonLineStyle(
                      width: double.infinity, height: 16),
                  leadingStyle: const SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                  ),
                );
              },
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => UserListTile(
              user: state.users[index],
              trailing: Checkbox(
                value: true,
                onChanged: (value) {},
              ),
            ),
            itemCount: state.users.length,
          );
        },
      ),
    );
  }
}
