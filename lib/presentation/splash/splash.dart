import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoaded) {
          AutoRouter.of(context).replace(const HomePageRoute());
        } else if (state is AuthStateError) {
          AutoRouter.of(context).replace(const LoginPageRoute());
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
