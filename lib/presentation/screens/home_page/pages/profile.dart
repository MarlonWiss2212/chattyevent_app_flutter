import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: TextButton(
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

                  return UserProfileDataPage(user: foundUser);
                } else if (state is UserStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: TextButton(
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
