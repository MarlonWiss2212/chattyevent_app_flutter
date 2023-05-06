import 'dart:async';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) => BlocProvider.of<AuthCubit>(context)
          .checkIfEmailVerfiedIfSoGoToCreateUserPage(),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Bestätigen"),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocListener<NotificationCubit, NotificationState>(
        listener: (context, state) async {
          if (state is NotificationAlert) {
            return await showDialog(
              context: context,
              builder: (c) {
                return CustomAlertDialog(
                  notificationAlert: state,
                  context: c,
                );
              },
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.email,
                  size: min(200, MediaQuery.of(context).size.width / 2),
                ),
                const SizedBox(height: 20),
                PlatformElevatedButton(
                  child: const Text("Erneut Senden"),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).sendEmailVerification();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
