import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/request_user_id_filter.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class ProfileFollowRequestsTabListView extends StatelessWidget {
  final List<UserEntity> followRequests;
  const ProfileFollowRequestsTabListView({
    super.key,
    required this.followRequests,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return UserListTile(
          user: followRequests[index],
          trailing: Wrap(
            spacing: 4,
            children: [
              InkWell(
                onTap: () {
                  BlocProvider.of<ProfilePageCubit>(context)
                      .acceptFollowRequest(
                    userId: followRequests[index].id,
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Ink(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Text(
                      "Akzeptieren",
                      style: Theme.of(context).textTheme.labelMedium?.apply(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<ProfilePageCubit>(context)
                      .deleteFollowRequest(
                    userId: followRequests[index].id,
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Ink(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                    ),
                    child: Text(
                      "Ablehnen",
                      style: Theme.of(context).textTheme.labelMedium?.apply(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: followRequests.length,
    );
  }
}
