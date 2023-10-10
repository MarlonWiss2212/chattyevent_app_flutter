import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state_status.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/ad_mob_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chatty_event_logo_and_text_auth_pages.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/auth_pages/dataprotection_checkbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AdMobUseCases adMobUseCases = serviceLocator<AdMobUseCases>();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await adMobUseCases.showAdMobPopUpIfRequired();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("loginPage.title").tr(),
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
                          labelText: "loginPage.emailLable".tr(),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailFieldController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "loginPage.passwordLable".tr(),
                          prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        ),
                        controller: passwordFieldController,
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
                                .loginWithEmailAndPassword(
                              email: emailFieldController.text,
                              password: passwordFieldController.text,
                            );
                          },
                          text: "loginPage.loginText".tr(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).push(
                            ResetPasswordRoute(
                              standardEmail: emailFieldController.text,
                            ),
                          );
                        },
                        child: const Text(
                          "loginPage.passwordForgottenText",
                        ).tr(),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).replace(
                            const RegisterRoute(),
                          );
                        },
                        child: const Text(
                          "loginPage.registerInsteadText",
                        ).tr(),
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
