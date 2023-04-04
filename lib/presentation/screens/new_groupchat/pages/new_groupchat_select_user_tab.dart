import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_groupchat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/create_groupchat_user_from_create_groupchat_dto.dart';

import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/selected_user_list.dart';

class NewGroupchatSelectUserTab extends StatelessWidget {
  const NewGroupchatSelectUserTab({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsersViaApi();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
        buildWhen: (p, c) => p.groupchatUsers.length != c.groupchatUsers.length,
        builder: (context, state) {
          return Column(
            children: [
              SelectedUsersList(
                users: state.groupchatUsers.map((e) => e.user).toList(),
                onPress: (user) => BlocProvider.of<AddGroupchatCubit>(context)
                    .removeGroupchatUserUserFromList(
                  userId: user.id,
                ),
              ),
              SelectableUserGridList(
                filterUsers: (users) {
                  List<UserEntity> filteredUsers = [];

                  for (final user in users) {
                    int foundIndex = state.groupchatUsers.indexWhere(
                      (groupchatUser) => groupchatUser.user.id == user.id,
                    );
                    if (foundIndex == -1) {
                      filteredUsers.add(user);
                    }
                  }
                  return filteredUsers;
                },
                onUserPress: (user) {
                  BlocProvider.of<AddGroupchatCubit>(context)
                      .addGroupchatUserToList(
                    groupchatUser:
                        CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity(
                      user: user,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
