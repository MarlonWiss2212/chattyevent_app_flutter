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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrieren"),
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
                      ),
                      const SizedBox(height: 8),
                      PlatformTextFormField(
                        controller: passwordFieldController,
                        obscureText: true,
                        hintText: 'Passwort',
                      ),
                      const SizedBox(height: 16),
                      const DataprotectionCheckbox(),
                      const SizedBox(height: 16),
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) async {
                          if (state.status == AuthStateStatus.loggedIn &&
                              state.token != null) {
                            AutoRouter.of(context)
                                .replace(const HomePageRoute());
                          }
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Button(
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context)
                                  .registerWithEmailAndPassword(
                                email: emailFieldController.text,
                                password: passwordFieldController.text,
                              );
                            },
                            text: "Registrieren",
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PlatformTextButton(
                        onPressed: () {
                          AutoRouter.of(context)
                              .replace(const LoginPageRoute());
                        },
                        child: const Text("Login?"),
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
