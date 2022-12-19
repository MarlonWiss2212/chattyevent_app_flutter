import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  final bool loadUser;
  const ProfilePage({
    super.key,
    @PathParam('id') required this.userId,
    this.loadUser = true,
  });

  @override
  Widget build(BuildContext context) {
    if (loadUser) {
      BlocProvider.of<UserBloc>(context).add(GetOneUserEvent(
        getOneUserFilter: GetOneUserFilter(id: userId),
      ));
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        UserEntity? foundUser;
        if (state is UserStateLoaded) {
          for (final user in state.users) {
            if (user.id == userId) {
              foundUser = user;
              break;
            }
          }
        }

        Widget body;
        if (state is UserStateLoaded) {
          if (foundUser == null) {
            return Center(
              child: PlatformTextButton(
                child: const Text("Keinen User gefunden"),
                onPressed: () => BlocProvider.of<UserBloc>(context).add(
                  GetOneUserEvent(
                    getOneUserFilter: GetOneUserFilter(id: userId),
                  ),
                ),
              ),
            );
          }

          body = UserProfileDataPage(user: foundUser);
        } else if (state is UserStateLoading) {
          body = Center(child: PlatformCircularProgressIndicator());
        } else {
          body = Center(
            child: PlatformTextButton(
              child: Text(
                state is UserStateError ? state.message : "User Laden",
              ),
              onPressed: () => BlocProvider.of<UserBloc>(context).add(
                GetOneUserEvent(
                  getOneUserFilter: GetOneUserFilter(id: userId),
                ),
              ),
            ),
          );
        }

        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(
              foundUser != null
                  ? foundUser.username ?? "Profilseite"
                  : "Profilseite",
            ),
          ),
          body: body,
        );
      },
    );
  }
}
