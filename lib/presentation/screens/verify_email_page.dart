import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: const Text("Email Bestätigen")),
      body: SingleChildScrollView(
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
    );
  }
}
