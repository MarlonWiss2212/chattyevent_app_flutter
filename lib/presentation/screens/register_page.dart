import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/ok_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameFieldController = TextEditingController();
  final firstnameFieldController = TextEditingController();
  final lastnameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  DateTime birthdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrieren"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: usernameFieldController,
              decoration: const InputDecoration(hintText: 'Benutzername'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: firstnameFieldController,
              decoration: const InputDecoration(hintText: 'Vorname'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: lastnameFieldController,
              decoration: const InputDecoration(hintText: 'Nachname'),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  DateTime currentDate = DateTime.now();
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: birthdate,
                    firstDate: DateTime(currentDate.year - 200),
                    lastDate: currentDate,
                  );

                  if (newDate == null) return;
                  setState(() {
                    birthdate = newDate;
                  });
                },
                child: Text("Geburtstag: $birthdate"),
              ),
            ),
            const SizedBox(height: 8),
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
            BlocListener<AuthBloc, AuthState>(
              listenWhen: (previous, current) {
                return current is AuthStateError;
              },
              listener: (context, state) async {
                if (state is AuthStateError) {
                  return await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(state.title ?? "Kein Titel"),
                        content: Text(state.message),
                        actions: const [OKButton()],
                      );
                    },
                  );
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      AuthRegisterEvent(
                        createUserDto: CreateUserDto(
                          username: usernameFieldController.text,
                          firstname: firstnameFieldController.text,
                          lastname: lastnameFieldController.text,
                          birthdate: birthdate,
                          email: emailFieldController.text,
                          password: passwordFieldController.text,
                        ),
                      ),
                    );
                  },
                  child: const Text("Registrieren"),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                AutoRouter.of(context).replace(const LoginPageRoute());
              },
              child: const Text("Login?"),
            )
          ],
        ),
      ),
    );
  }
}
