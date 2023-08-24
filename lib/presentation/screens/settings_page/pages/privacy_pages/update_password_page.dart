import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

@RoutePage()
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Password aktualisieren"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Neues Passwort',
                  prefixIcon: Icon(CupertinoIcons.lock_fill),
                ),
                controller: passwordFieldController,
                obscureText: true,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Bestätigung neues Passwort',
                  prefixIcon: Icon(CupertinoIcons.lock_fill),
                ),
                controller: verifyPasswordFieldController,
                obscureText: true,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Button(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).updatePassword(
                      password: passwordFieldController.text,
                      verifyPassword: verifyPasswordFieldController.text,
                    );
                  },
                  text: "Passwort ändern",
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context)
                        .sendResetPasswordEmail();
                  },
                  child: const Text(
                    "Du kannst dich nicht neu verifizieren? Sende Passwort zurücksetzen E-Mail",
                    textAlign: TextAlign.center,
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
