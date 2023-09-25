import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_groupchat/add_groupchat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/create_groupchat_user_from_create_groupchat_dto.dart';
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
      notTheseUserIds: BlocProvider.of<AddGroupchatCubit>(context)
          .state
          .groupchatUsers
          .map((e) => e.userId)
          .toList(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
        builder: (context, state) {
          return Column(
            children: [
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
                  reloadRequest: ({String? text}) {
                    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                      search: text,
                      notTheseUserIds:
                          state.groupchatUsers.map((e) => e.userId).toList(),
                    );
                  },
                  loadMoreRequest: ({String? text}) {
                    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                      loadMore: true,
                      search: text,
                      notTheseUserIds:
                          state.groupchatUsers.map((e) => e.userId).toList(),
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
