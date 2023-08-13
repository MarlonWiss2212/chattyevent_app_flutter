import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/follow_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class ProfileFollowedTabListView extends StatelessWidget {
  final List<UserEntity> followed;
  final void Function() loadMore;
  final bool loading;
  const ProfileFollowedTabListView({
    super.key,
    required this.followed,
    required this.loadMore,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < followed.length) {
            return UserListTile(
              user: followed[index],
              trailing: SizedBox(
                width: 100,
                height: 40,
                child: FollowButton(
                  user: followed[index],
                  onTap: (UserRelationStatusEnum? value) {
                    BlocProvider.of<ProfilePageCubit>(context)
                        .createUpdateUserOrDeleteRelationViaApi(
                      user: followed[index],
                      value: value,
                    );
                  },
                ),
              ),
            );
          }
          if (loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return IconButton(
              onPressed: loadMore,
              icon: const Icon(Icons.add_circle),
            );
          }
        },
        childCount: followed.length + 1,
      ),
    );
  }
}
