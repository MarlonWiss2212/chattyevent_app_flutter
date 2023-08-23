import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

@RoutePage()
class UpdateEmailPage extends StatefulWidget {
  const UpdateEmailPage({super.key});

  @override
  State<UpdateEmailPage> createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  AuthUseCases authUseCases = serviceLocator();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController verifyEmailFieldController = TextEditingController();
  String emailAddress = "";

  Future<void> setEmailAddress() async {
    final response = await authUseCases.refreshUser();
    response.fold(
      (alert) => null,
      (user) => setState(
        () => emailAddress = user.email ?? "",
      ),
    );
  }

  @override
  void initState() {
    setEmailAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("E-Mail aktualisieren"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (emailAddress != "") ...{
                Text(
                  "E-Mail Addresse: $emailAddress",
                ),
              },
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Neue E-Mail',
                  prefixIcon: Icon(Icons.email),
                ),
                controller: emailFieldController,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Bestätigung neue E-Mail',
                  prefixIcon: Icon(Icons.email),
                ),
                controller: verifyEmailFieldController,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Button(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).verifyBeforeUpdateEmail(
                      email: emailFieldController.text,
                      verifyEmail: verifyEmailFieldController.text,
                    );
                  },
                  text: "E-Mail ändern",
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
