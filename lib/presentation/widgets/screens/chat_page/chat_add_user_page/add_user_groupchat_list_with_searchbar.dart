import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/selectable_user_grid_list.dart';

class AddUserGroupchatListWithSearchbar extends StatelessWidget {
  const AddUserGroupchatListWithSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
        builder: (context, state) {
          return SelectableUserGridList(
            showTextSearch: true,
            reloadRequest: ({String? text}) {
              BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                search: text,
                notTheseUserIds: state.users.map((e) => e.id).toList(),
              );
            },
            loadMoreRequest: ({String? text}) {
              BlocProvider.of<UserSearchCubit>(context).getFollowedViaApi(
                loadMore: true,
                search: text,
                notTheseUserIds: state.users.map((e) => e.id).toList(),
              );
            },
            userButton: (user) => Button(
              color: Theme.of(context).colorScheme.primaryContainer,
              onTap: () {
                BlocProvider.of<CurrentGroupchatCubit>(context)
                    .addUserToChat(userId: user.id);
              },
              text: "general.addText".tr(),
            ),
          );
        },
      ),
    );
  }
}
