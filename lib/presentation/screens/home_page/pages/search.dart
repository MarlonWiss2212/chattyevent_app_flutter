import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
      bloc: BlocProvider.of<UserBloc>(context)
        ..add(
          UserRequestEvent(),
        ),
      builder: (context, state) {
        if (state is UserStateLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                title: Text(state.users[index].username ?? "Kein Benutzername"),
                onTap: () {},
              );
            },
            itemCount: state.users.length,
          );
        } else if (state is UserStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: TextButton(
              child: Text(
                state is UserStateError ? state.message : "Daten laden",
              ),
              onPressed: () => BlocProvider.of<UserBloc>(context).add(
                UserRequestEvent(),
              ),
            ),
          );
        }
      },
    ));
  }
}
