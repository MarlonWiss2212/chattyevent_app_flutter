import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';

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
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailFieldController,
              decoration: const InputDecoration(hintText: 'E-Mail'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: passwordFieldController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(hintText: 'Passwort'),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    AuthLoginEvent(
                      email: emailFieldController.text,
                      password: passwordFieldController.text,
                    ),
                  );
                },
                child: const Text("Einloggen"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
