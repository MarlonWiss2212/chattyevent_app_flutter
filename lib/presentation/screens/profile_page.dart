import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_messages_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class ProfilePage extends StatefulWidget {
  final UserEntity user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username ?? "Profilseite"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: BlocProvider.of<UserBloc>(context)
          ..add(
            GetOneUserEvent(
              getOneUserFilter: GetOneUserFilter(id: widget.user.id),
            ),
          ),
        builder: (context, state) {
          if (state is UserStateLoaded) {
            UserEntity? foundUser;
            for (final user in state.users) {
              if (user.id == widget.user.id) {
                foundUser = user;
              }
            }

            if (foundUser == null) {
              return Center(
                child: TextButton(
                  child: const Text("Keinen User gefunden"),
                  onPressed: () => BlocProvider.of<UserBloc>(context).add(
                    GetOneUserEvent(
                      getOneUserFilter: GetOneUserFilter(id: widget.user.id),
                    ),
                  ),
                ),
              );
            }

            return UserProfileDataPage(user: foundUser);
          } else if (state is UserStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: TextButton(
                child: Text(
                  state is UserStateError ? state.message : "User Laden",
                ),
                onPressed: () => BlocProvider.of<UserBloc>(context).add(
                  GetOneUserEvent(
                    getOneUserFilter: GetOneUserFilter(id: widget.user.id),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
