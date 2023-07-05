import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupchatAddMePageUserList extends StatelessWidget {
  const GroupchatAddMePageUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<UserSearchCubit, UserSearchState>(
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) => UserListTile(
              user: state.users[index],
              trailing: Checkbox(
                value: true,
                onChanged: (value) {},
              ),
            ),
            itemCount: state.users.length,
          );
        },
      ),
    );
  }
}
