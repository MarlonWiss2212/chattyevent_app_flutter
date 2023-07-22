import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_groupchat/add_groupchat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selected_user_list.dart';

@RoutePage()
class NewGroupchatSelectUserTab extends StatefulWidget {
  const NewGroupchatSelectUserTab({super.key});

  @override
  State<NewGroupchatSelectUserTab> createState() =>
      _NewGroupchatSelectUserTabState();
}

class _NewGroupchatSelectUserTabState extends State<NewGroupchatSelectUserTab> {
  @override
  void initState() {
    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
      filterForGroupchatAddMeAllowedUsers: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
        buildWhen: (p, c) => p.groupchatUsers.length != c.groupchatUsers.length,
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Mitglieder hinzufügen",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              SelectedUsersList(
                users: state.groupchatUsers.map((e) => e.user).toList(),
                onPress: (user) => BlocProvider.of<AddGroupchatCubit>(context)
                    .removeGroupchatUserUserFromList(
                  userId: user.id,
                ),
              ),
              Expanded(
                child: SelectableUserGridList(
                  //TODO: in future over api
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
                  reloadRequest: ({String? text}) {
                    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                      filterForGroupchatAddMeAllowedUsers: true,
                      search: text,
                    );
                  },
                  loadMoreRequest: ({String? text}) {
                    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                      loadMore: true,
                      filterForGroupchatAddMeAllowedUsers: true,
                      search: text,
                    );
                  },
                  showTextSearch: true,
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
              ),
            ],
          );
        },
      ),
    );
  }
}
