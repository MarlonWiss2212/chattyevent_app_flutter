import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_item.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<UserSearchBloc, UserSearchState>(
      bloc: BlocProvider.of<UserSearchBloc>(context)
        ..add(
          SearchUsersEvent(),
        ),
      builder: (context, state) {
        if (state is UserSearchStateLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return UserListItem(
                user: state.users[index],
                onPress: () {},
              );
            },
            itemCount: state.users.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: max(
                (MediaQuery.of(context).size.width ~/ 150).toInt(),
                1,
              ),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
          );
        } else if (state is UserSearchStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: TextButton(
              child: Text(
                state is UserSearchStateError ? state.message : "User laden",
              ),
              onPressed: () => BlocProvider.of<UserSearchBloc>(context).add(
                SearchUsersEvent(),
              ),
            ),
          );
        }
      },
    ));
  }
}
