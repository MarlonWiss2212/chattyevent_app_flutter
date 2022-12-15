import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_grid_list.dart';

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
            return UserGridList(
              users: state.users,
              onPress: (user) {
                AutoRouter.of(context).push(ProfilePageRoute(user: user));
              },
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
      ),
    );
  }
}
