import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController verifyPasswordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Password erneuern"),
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
                controller: passwordFieldController,
                obscureText: true,
                hintText: 'Neues Passwort',
              ),
              const SizedBox(height: 8),
              PlatformTextFormField(
                controller: verifyPasswordFieldController,
                obscureText: true,
                hintText: 'Bestätigung Neues Passwort',
              ),
              const SizedBox(height: 8),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state.sendedResetPasswordEmail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Passwort geändert"),
                      ),
                    );
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: PlatformElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).updatePassword(
                        password: passwordFieldController.text,
                        verifyPassword: verifyPasswordFieldController.text,
                      );
                    },
                    child: const Text("Passwort ändern"),
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
