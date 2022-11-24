import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_profile/user_profile_bloc.dart';
import 'package:social_media_app_flutter/infastructure/models/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateLoaded) {
            Map<String, dynamic> tokenPayload = Jwt.parseJwt(state.token);

            return BlocBuilder<UserProfileBloc, UserProfileState>(
              bloc: BlocProvider.of<UserProfileBloc>(context)
                ..add(
                  UserProfileRequestEvent(userId: tokenPayload["sub"]),
                ),
              builder: (context, state) {
                if (state is UserProfileStateLoaded) {
                  return ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      // Profile Image
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                width: min(size.width / 3, 150),
                                height: min(size.width / 3, 150),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100000000000000),
                                  ),
                                ),
                              ),
                              // name
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  state.userProfile.username,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is UserProfileStateLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return Center(
                    child: TextButton(
                      child: Text(
                        state is UserProfileStateError
                            ? state.message
                            : "Daten laden",
                      ),
                      onPressed: () =>
                          BlocProvider.of<UserProfileBloc>(context).add(
                        UserProfileRequestEvent(userId: tokenPayload["sub"]),
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
