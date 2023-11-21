import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/event_user/create_event_user_from_event_dto.dart';
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
  String text = "";
  @override
  void initState() {
    super.initState();
  }

  Future<void> _reloadRequest(AddEventState state) async {
    return await BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
      search: text,
      notTheseUserIds: state.privateEventUsersDto.map((e) => e.userId).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddEventCubit, AddEventState>(
        buildWhen: (p, c) =>
            p.privateEventUsersDto.length != c.privateEventUsersDto.length,
        builder: (context, state) {
          _reloadRequest(state);
          return Column(
            children: [
              SelectedUsersList(
                users: state.privateEventUsersDto.map((e) => e.user).toList(),
                onPress: (user) {
                  BlocProvider.of<AddEventCubit>(context)
                      .removePrivateEventUserFromList(
                    userId: user.id,
                  );
                },
              ),
              Expanded(
                child: SelectableUserGridList(
                  reloadRequest: ({String? text}) {
                    this.text = text ?? this.text;
                    _reloadRequest(state);
                  },
                  loadMoreRequest: ({String? text}) {
                    this.text = text ?? this.text;
                    BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                      loadMore: true,
                      search: this.text,
                      notTheseUserIds: state.privateEventUsersDto
                          .map((e) => e.userId)
                          .toList(),
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
