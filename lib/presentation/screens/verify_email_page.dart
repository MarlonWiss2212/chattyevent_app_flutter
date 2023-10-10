import 'dart:async';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';

@RoutePage()
class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  AuthUseCases authUseCases = serviceLocator();
  String emailAddress = "";

  Future<void> setEmailAddress() async {
    final responseFirebaseUser = authUseCases.getFirebaseUser();
    responseFirebaseUser.fold(
      (alert) => null,
      (user) => setState(() => emailAddress = user.email ?? ""),
    );
    final response = await authUseCases.refreshUser();
    response.fold(
      (alert) => null,
      (user) => setState(() => emailAddress = user.email ?? ""),
    );
  }

  late Timer timer;

  @override
  void initState() {
    setEmailAddress();
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) async {
        if (await serviceLocator<AuthUseCases>().isEmailVerified()) {
          serviceLocator<AppRouter>().replace(const CreateUserRoute());
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("verifyEmailPage.title").tr(),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logout();
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
              Text(emailAddress),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Button(
                  text: "verifyEmailPage.resendEmail".tr(),
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).sendEmailVerification();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
