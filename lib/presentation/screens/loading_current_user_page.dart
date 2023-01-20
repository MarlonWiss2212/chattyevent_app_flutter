import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class LoadingCurrentUserPage extends StatelessWidget {
  const LoadingCurrentUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoadingCurrentUser) {
        } else if (state is AuthStateLoaded) {
          AutoRouter.of(context).replace(const HomePageRoute());
        } else {
          AutoRouter.of(context).replace(const LoginPageRoute());
        }
      },
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          title: const Text("Lade Benutzer"),
        ),
        body: Expanded(
          child: Center(
            child: PlatformCircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
