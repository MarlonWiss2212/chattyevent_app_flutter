import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_user/create_event_user_from_event_dto.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selected_user_list.dart';

class NewPrivateEventSearchUserTab extends StatefulWidget {
  const NewPrivateEventSearchUserTab({super.key});

  @override
  State<NewPrivateEventSearchUserTab> createState() =>
      _NewPrivateEventSearchUserTabState();
}

class _NewPrivateEventSearchUserTabState
    extends State<NewPrivateEventSearchUserTab> {
  @override
  void initState() {
    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
      filterForPrivateEventAddMeAllowedUsers: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddEventCubit, AddEventState>(
        buildWhen: (p, c) =>
            p.privateEventUsersDto.length != c.privateEventUsersDto.length,
        builder: (context, state) {
          return Column(
            children: [
              SelectedUsersList(
                users: state.privateEventUsersDto.map((e) => e.user).toList(),
                onPress: (user) => BlocProvider.of<AddEventCubit>(context)
                    .removePrivateEventUserFromList(
                  userId: user.id,
                ),
              ),
              Expanded(
                child: SelectableUserGridList(
                  filterUsers: (users) {
                    List<UserEntity> filteredUsers = [];

                    for (final user in users) {
                      int foundIndex = state.privateEventUsersDto.indexWhere(
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
                      filterForPrivateEventAddMeAllowedUsers: true,
                      search: text,
                    );
                  },
                  loadMoreRequest: ({String? text}) {
                    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                      loadMore: true,
                      filterForPrivateEventAddMeAllowedUsers: true,
                      search: text,
                    );
                  },
                  showTextSearch: true,
                  onUserPress: (user) {
                    BlocProvider.of<AddEventCubit>(context)
                        .addPrivateEventUserToList(
                      privateEventUserDto:
                          CreateEventUserFromEventDtoWithUserEntity(
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
