import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/imprint/imprint_cubit.dart';
import 'package:chattyevent_app_flutter/domain/usecases/one_signal_use_cases.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';

@RoutePage()
class BlocInitPage extends StatefulWidget {
  const BlocInitPage({super.key});

  @override
  State<BlocInitPage> createState() => _BlocInitPageState();
}

class _BlocInitPageState extends State<BlocInitPage> {
  late OneSignalUseCases oneSignalUseCases;

  @override
  void initState() {
    oneSignalUseCases = serviceLocator<OneSignalUseCases>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    oneSignalUseCases.setNotificationReceivedHandler(
      appRouter: serviceLocator<AppRouter>(),
    );
    oneSignalUseCases.setNotificationReceivedHandler(
      appRouter: serviceLocator<AppRouter>(),
    );
    BlocProvider.of<AuthCubit>(context).setCurrentUserFromFirebaseViaApi();

    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) => p.token != c.token,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => HomeEventCubit(
                eventUseCases: serviceLocator(),
                notificationCubit: serviceLocator(),
              ),
            ),
            BlocProvider(
              create: (_) => ImprintCubit(
                imprintUseCases: serviceLocator(),
                notificationCubit: serviceLocator(),
              ),
            ),
            BlocProvider(
              create: (_) => ChatCubit(
                chatUseCases: serviceLocator(),
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
