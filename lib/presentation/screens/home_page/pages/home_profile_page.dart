import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page_own_user.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserId = "";

    final authState = BlocProvider.of<AuthBloc>(context).state;

    if (authState is AuthStateLoaded) {
      currentUserId = Jwt.parseJwt(authState.token)["sub"];
    }

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
        trailingActions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());

              BlocProvider.of<ChatBloc>(context).add(ChatInitialEvent());
              BlocProvider.of<MessageBloc>(context).add(
                MessageInitialEvent(),
              );
              BlocProvider.of<PrivateEventBloc>(context).add(
                PrivateEventInitialEvent(),
              );
              BlocProvider.of<UserBloc>(context).add(UserInitialEvent());
              BlocProvider.of<UserSearchBloc>(context).add(
                UserSearchInitialEvent(),
              );

              AutoRouter.of(context).popUntilRoot();
              AutoRouter.of(context).replace(const LoginPageRoute());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: BlocProvider.of<UserBloc>(context)
          ..add(
            GetOneUserEvent(
              getOneUserFilter: GetOneUserFilter(
                id: currentUserId,
              ),
            ),
          ),
        builder: (context, state) {
          if (state is UserStateLoaded) {
            UserEntity? foundUser;
            for (final user in state.users) {
              if (user.id == currentUserId) {
                foundUser = user;
              }
            }

            if (foundUser == null) {
              return Center(
                child: PlatformTextButton(
                  child: const Text("Keinen User gefunden"),
                  onPressed: () => BlocProvider.of<UserBloc>(context).add(
                    GetOneUserEvent(
                      getOneUserFilter: GetOneUserFilter(
                        id: currentUserId,
                      ),
                    ),
                  ),
                ),
              );
            }

            return UserProfileDataPageOwnUser(user: foundUser);
          } else if (state is UserStateLoading) {
            return Center(child: PlatformCircularProgressIndicator());
          } else {
            return Center(
              child: PlatformTextButton(
                child: Text(
                  state is UserStateError ? state.message : "User laden",
                ),
                onPressed: () => BlocProvider.of<UserBloc>(context).add(
                  GetOneUserEvent(
                    getOneUserFilter: GetOneUserFilter(
                      id: currentUserId,
                    ),
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
