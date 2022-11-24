import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';

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
          UserSearchRequestEvent(),
        ),
      builder: (context, state) {
        if (state is UserSearchStateLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                title: Text(state.users[index].username),
                onTap: () {},
              );
            },
            itemCount: state.users.length,
          );
        } else if (state is UserSearchStateLoading) {
          return const CircularProgressIndicator();
        } else {
          return Center(
            child: TextButton(
              child: Text(
                state is UserSearchStateError ? state.message : "Daten laden",
              ),
              onPressed: () => BlocProvider.of<UserSearchBloc>(context).add(
                UserSearchRequestEvent(),
              ),
            ),
          );
        }
      },
    ));
  }
}
