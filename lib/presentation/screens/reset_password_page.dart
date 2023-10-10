import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

@RoutePage()
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("resetPasswordPage.title").tr(),
      ),
      body: BlocListener<NotificationCubit, NotificationState>(
        listener: (context, state) async {
          state.listenerFunction(context);
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "resetPasswordPage.emailLable".tr(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailFieldController,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (newValue) {
                    BlocProvider.of<AuthCubit>(context).sendResetPasswordEmail(
                      email: emailFieldController.text,
                    );
                  },
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Button(
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context)
                          .sendResetPasswordEmail(
                        email: emailFieldController.text,
                      );
                    },
                    text: "resetPasswordPage.sendEmailLable".tr(),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
