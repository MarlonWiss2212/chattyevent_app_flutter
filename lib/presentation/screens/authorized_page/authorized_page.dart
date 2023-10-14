import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_map/home_map_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/requests/requests_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/one_signal_use_cases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/permission_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthorizedPage extends StatefulWidget {
  const AuthorizedPage({super.key});

  @override
  State<AuthorizedPage> createState() => _AuthorizedPageState();
}

class _AuthorizedPageState extends State<AuthorizedPage> {
  final PermissionUseCases permissionUseCases = serviceLocator();
  @override
  void initState() {
    super.initState();
    final OneSignalUseCases oneSignalUseCases =
        serviceLocator<OneSignalUseCases>();
    oneSignalUseCases.setNotificationReceivedHandlerIfIHavePermission(
      appRouter: serviceLocator<AppRouter>(),
    );
    oneSignalUseCases.setNotificationOpenedHandlerIfIHavePermission(
      appRouter: serviceLocator<AppRouter>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    InjectionUtils.initializeAuthenticatedLocator();
    BlocProvider.of<AuthCubit>(context).userUseCases = authenticatedLocator();
    BlocProvider.of<AuthCubit>(context).setCurrentUserFromFirebaseViaApi();

    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) async {
        state.listenerFunction(context);
      },
      child: MultiBlocProvider(
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
          BlocProvider(
            create: (_) => authenticatedLocator<HomeMapCubit>(),
          ),
          BlocProvider(create: (_) => authenticatedLocator<ChatCubit>()),
        ],
        child: const AutoRouter(),
      ),
    );
  }
}
