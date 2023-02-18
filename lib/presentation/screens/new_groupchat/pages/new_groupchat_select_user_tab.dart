import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/new_groupchat/new_groupchat_select_user_tab/selectable_user_grid_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/new_groupchat/new_groupchat_select_user_tab/selected_user_list.dart';

class NewGroupchatSelectUserTab extends StatelessWidget {
  const NewGroupchatSelectUserTab({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSearchCubit>(context).getUsersViaApi();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: const [
          SelectedUsersList(),
          SelectableUserGridList(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
