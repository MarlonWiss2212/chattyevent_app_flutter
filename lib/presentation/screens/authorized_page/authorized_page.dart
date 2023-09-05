import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthorizedPage extends StatefulWidget {
  const AuthorizedPage({super.key});

  @override
  State<AuthorizedPage> createState() => _AuthorizedPageState();
}

class _AuthorizedPageState extends State<AuthorizedPage> {
  late Timer timer;

  @override
  void initState() {
    //TODO optimize this and only refresh when sending new request
    timer = Timer.periodic(
      const Duration(minutes: 60),
      (timer) => BlocProvider.of<AuthCubit>(context).refreshAuthToken(
        force: true,
      ),
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
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) async {
        state.listenerFunction(context);
      },
      child: const AutoRouter(),
    );
  }
}
