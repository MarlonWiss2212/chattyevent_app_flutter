import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class FailureLoadingCurrentUserPage extends StatelessWidget {
  const FailureLoadingCurrentUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("User nicht gefunden"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthError) {
                          AutoRouter.of(context)
                              .replace(const LoginPageRoute());
                        }

                        if (state is AuthErrorUserData) {
                          return Text(
                            "Fehler beim Laden von dem User mit der Id: ${state.token}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }
                        return const Text("Fehler beim Laden von dem User");
                      },
                    ),
                    const SizedBox(height: 8),
                    const Text("Überprüfe auch deine Internetverbindung")
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: PlatformElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logout();
                },
                child: const Text("Logout"),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
