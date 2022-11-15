import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          children: [
            TextField(
              controller: emailFieldController,
              decoration: const InputDecoration(hintText: 'E-Mail'),
            ),
            TextField(
              controller: passwordFieldController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(hintText: 'Passwort'),
            ),
            Mutation(
              options: MutationOptions(
                document: gql("""
                  mutation login(\$input: LoginUserInput!) {
                    login(loginUserInput: \$input) {
                      access_token
                    }
                  }
                  """),
                onCompleted: (data) async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('access_token', data!['acces_token']);
                  Navigator.pushNamed(context, '/');
                },
              ),
              builder: (runMutation, result) {
                return TextButton(
                  onPressed: () {
                    runMutation({
                      'input': {
                        'email': emailFieldController.value,
                        'password': passwordFieldController.value
                      }
                    });
                  },
                  child: const Text("Einloggen"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
