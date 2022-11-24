import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';

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
            Mutation(
              options: MutationOptions(
                document: gql("""
                    mutation signup(\$input: CreateUserInput!) {
                      signup(loginUserInput: \$input) {
                        access_token
                      }
                    }
                    """),
                onCompleted: (data) {
                  if (data != null) {
                    BlocProvider.of<AuthBloc>(context).add(
                      AuthRegisterEvent(
                          email: emailFieldController.text,
                          password: passwordFieldController.text),
                    );
                    Navigator.popAndPushNamed(context, '/');
                  }
                },
              ),
              builder: (runMutation, result) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      runMutation({
                        'input': {
                          'username': usernameFieldController.text,
                          'firstname': firstnameFieldController.text,
                          'lastname': lastnameFieldController.text,
                          'birthdate': birthdate.toIso8601String(),
                          'email': emailFieldController.text,
                          'password': passwordFieldController.text
                        }
                      });
                    },
                    child: const Text("Registrieren"),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
