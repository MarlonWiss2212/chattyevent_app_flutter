import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? standardEmail;
  const ResetPasswordPage({super.key, this.standardEmail});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailFieldController = TextEditingController();

  @override
  void initState() {
    emailFieldController.text = widget.standardEmail ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Password Zurücksetzen"),
      ),
      body: Center(
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
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state.status == AuthStateStatus.success &&
                      state.token != null) {
                    AutoRouter.of(context).replace(const HomePageRoute());
                  } else if (state.sendedResetPasswordEmail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email gesendet"),
                      ),
                    );
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: PlatformElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context)
                          .sendResetPasswordEmail(
                        email: emailFieldController.text,
                      );
                    },
                    child: const Text("Sende Email"),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
