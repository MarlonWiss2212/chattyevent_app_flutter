import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/requests/requests_cubit.dart';
import 'package:chattyevent_app_flutter/domain/usecases/one_signal_use_cases.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/ad_mob_usecases.dart';

@RoutePage()
class BlocInitPage extends StatefulWidget {
  const BlocInitPage({super.key});

  @override
  State<BlocInitPage> createState() => _BlocInitPageState();
}

class _BlocInitPageState extends State<BlocInitPage> {
  final AdMobUseCases adMobUseCases = serviceLocator<AdMobUseCases>();

  @override
  Future<void> initState() async {
    final OneSignalUseCases oneSignalUseCases =
        serviceLocator<OneSignalUseCases>();
    oneSignalUseCases.setNotificationReceivedHandler(
      appRouter: serviceLocator<AppRouter>(),
    );
    oneSignalUseCases.setNotificationOpenedHandler(
      appRouter: serviceLocator<AppRouter>(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await adMobUseCases.showAdMobPopUpIfRequired();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) => p.token != c.token,
      builder: (context, state) {
        return FutureBuilder(
          future: InjectionUtils.reinitializeAuthenticatedLocator(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator.adaptive()),
              );
            }

            BlocProvider.of<AuthCubit>(context).userUseCases =
                authenticatedLocator();
            BlocProvider.of<AuthCubit>(context)
                .setCurrentUserFromFirebaseViaApi();
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => authenticatedLocator<MessageStreamCubit>(),
                ),
                BlocProvider(
                  create: (_) => authenticatedLocator<RequestsCubit>(),
                ),
                BlocProvider(
                  create: (_) => authenticatedLocator<HomeEventCubit>(),
                ),
                BlocProvider(create: (_) => authenticatedLocator<ChatCubit>()),
              ],
              child: const AutoRouter(),
            );
          },
        );
      },
    );
  }
}
