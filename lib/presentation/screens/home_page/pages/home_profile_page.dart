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
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page_own_user.dart';

class HomeProfilePage extends StatefulWidget {
  const HomeProfilePage({super.key});

  @override
  State<HomeProfilePage> createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
        material: (context, platform) => MaterialAppBarData(
          actions: [
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
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateLoaded) {
            Map<String, dynamic> tokenPayload = Jwt.parseJwt(state.token);

            return BlocBuilder<UserBloc, UserState>(
              bloc: BlocProvider.of<UserBloc>(context)
                ..add(
                  GetOneUserEvent(
                    getOneUserFilter: GetOneUserFilter(
                      id: tokenPayload["sub"],
                    ),
                  ),
                ),
              builder: (context, state) {
                if (state is UserStateLoaded) {
                  UserEntity? foundUser;
                  for (final user in state.users) {
                    if (user.id == tokenPayload["sub"]) {
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
                              id: tokenPayload["sub"],
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
                            id: tokenPayload["sub"],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
