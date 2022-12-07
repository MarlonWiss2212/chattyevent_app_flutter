import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

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

            return BlocBuilder<UserBloc, UserState>(
              bloc: BlocProvider.of<UserBloc>(context)
                ..add(
                  GetOneUserEvent(userId: tokenPayload["sub"]),
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
                    return UserErrorUi(
                      userIdForRequest: tokenPayload["sub"],
                      errorMessage: "Fehler beim Laden vom User",
                    );
                  }

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
                                  foundUser.username ?? "Kein Benutzername",
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
                } else if (state is UserStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return UserErrorUi(
                    userIdForRequest: tokenPayload["sub"],
                    errorMessage: state is UserStateError
                        ? state.message
                        : "Fehler beim Laden vom User",
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

class UserErrorUi extends StatelessWidget {
  final String userIdForRequest;
  final String? errorMessage;
  const UserErrorUi({
    super.key,
    required this.userIdForRequest,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text(
          errorMessage ?? "Daten laden",
        ),
        onPressed: () => BlocProvider.of<UserBloc>(context).add(
          GetOneUserEvent(userId: userIdForRequest),
        ),
      ),
    );
    ;
  }
}
