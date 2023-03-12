import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/request_user_id_filter.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';

class ProfileFollowRequestsTab extends StatelessWidget {
  const ProfileFollowRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
      //  buildWhen: (previous, current) =>
      //      previous.userRelations?.length != current.userRelations?.length,
      builder: (context, state) {
        if (state.userRelations == null) {
          return const Center(
            child: Text("Keine Relationen"),
          );
        }
        List<UserRelationEntity> filteredRelations =
            state.userRelations!.where((element) {
          return element.targetUserId == state.user.id &&
              element.statusOnRelatedUser == "requestToFollow";
        }).toList();

        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                filteredRelations[index].requesterUserId ?? "Keine Id",
              ),
              trailing: InkWell(
                onTap: () {
                  if (filteredRelations[index].requesterUserId == null) {
                    return;
                  }
                  BlocProvider.of<ProfilePageCubit>(context)
                      .acceptFollowRequest(
                    requestUserIdFilter: RequestUserIdFilter(
                      requesterUserId:
                          filteredRelations[index].requesterUserId!,
                    ),
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
            );
          },
          itemCount: filteredRelations.length,
        );
      },
    );
  }
}
