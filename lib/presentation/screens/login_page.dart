import 'package:auto_route/auto_route.dart';

import 'package:chattyevent_app_flutter/presentation/widgets/screens/auth_pages/dataprotection_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: BlocListener<NotificationCubit, NotificationState>(
        listener: (context, state) async {
          if (state is NotificationAlert) {
            return await showDialog(
              context: context,
              builder: (c) {
                return CustomAlertDialog(
                  notificationAlert: state,
                  context: c,
                );
              },
            );
          }
        },
        child: Column(
          children: [
            BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              if (state.status == AuthStateStatus.loading) {
                return const LinearProgressIndicator();
              }
              return Container();
            }),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      PlatformTextFormField(
                        controller: emailFieldController,
                        hintText: 'E-Mail',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 8),
                      PlatformTextFormField(
                        controller: passwordFieldController,
                        obscureText: true,
                        hintText: 'Passwort',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      const DataprotectionCheckbox(),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          onTap: () {
                            BlocProvider.of<AuthCubit>(context)
                                .loginWithEmailAndPassword(
                              email: emailFieldController.text,
                              password: passwordFieldController.text,
                            );
                          },
                          text: "Einloggen",
                        ),
                      ),
                      const SizedBox(height: 16),
                      PlatformTextButton(
                        onPressed: () {
                          AutoRouter.of(context).push(
                            ResetPasswordPageRoute(
                              standardEmail: emailFieldController.text,
                            ),
                          );
                        },
                        child: const Text("Passwort vergessen?"),
                      ),
                      const SizedBox(height: 16),
                      PlatformTextButton(
                        onPressed: () {
                          AutoRouter.of(context).replace(
                            const RegisterPageRoute(),
                          );
                        },
                        child: const Text("Registrieren?"),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
