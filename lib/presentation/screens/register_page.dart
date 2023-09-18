import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chatty_event_logo_and_text_auth_pages.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/auth_pages/dataprotection_checkbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final verifyPasswordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("registerPage.title").tr(),
      ),
      body: BlocListener<NotificationCubit, NotificationState>(
        listener: (context, state) async {
          state.listenerFunction(context);
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ChattyEventLogoAndTextAuthPages(),
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "registerPage.emailLable".tr(),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailFieldController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "registerPage.passwordLable".tr(),
                          prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        ),
                        controller: passwordFieldController,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "registerPage.confirmPasswordLable".tr(),
                          prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        ),
                        controller: verifyPasswordFieldController,
                        obscureText: true,
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
                                .registerWithEmailAndPassword(
                              email: emailFieldController.text,
                              password: passwordFieldController.text,
                              verifyPassword:
                                  verifyPasswordFieldController.text,
                            );
                          },
                          text: "registerPage.registerText".tr(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).replace(const LoginRoute());
                        },
                        child: const Text("registerPage.loginInsteadText").tr(),
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
