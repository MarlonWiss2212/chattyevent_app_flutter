import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/imprint/imprint_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/one_signal_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class BlocInitPage extends StatelessWidget {
  const BlocInitPage({super.key});

  @override
  Widget build(BuildContext context) {
    // push route when open notification and receive
    OneSignalUtils.setNotificationOpenedHandler(serviceLocator<AppRouter>());
    OneSignalUtils.setNotificationReceivedHandler(serviceLocator<AppRouter>());
    BlocProvider.of<AuthCubit>(context).setCurrentUserFromFirebaseViaApi();

    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) => p.token != c.token,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeEventCubit(
                privateEventUseCases: serviceLocator(param1: state),
                notificationCubit: serviceLocator(),
              ),
            ),
            BlocProvider(
              create: (context) => ImprintCubit(
                imprintUseCases: serviceLocator(),
                notificationCubit: serviceLocator(),
              ),
            ),
            BlocProvider(
              create: (context) => ChatCubit(
                chatUseCase: serviceLocator(param1: state),
                notificationCubit: serviceLocator(),
              ),
            ),
          ],
          child: const AutoRouter(),
        );
      },
    );
  }
}
