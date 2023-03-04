import 'dart:async';
import 'dart:math';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      BlocProvider.of<AuthCubit>(context).reloadUser();
      final currentUser = serviceLocator<FirebaseAuth>().currentUser;
      if (currentUser != null && currentUser.emailVerified) {
        AutoRouter.of(context).replace(const CreateUserPageRoute());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Email Bestätigen"),
        trailingActions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logout();
              AutoRouter.of(context).root.popUntilRoot();
              AutoRouter.of(context).root.replace(const LoginPageRoute());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.email,
                size: min(200, MediaQuery.of(context).size.width / 2),
              ),
              const SizedBox(height: 20),
              PlatformElevatedButton(
                child: const Text("Erneut Senden"),
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).sendEmailVerification();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
