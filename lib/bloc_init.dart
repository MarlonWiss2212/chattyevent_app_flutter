import 'package:chattyevent_app_flutter/application/bloc/imprint/imprint_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/one_signal_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/location/location_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/image/image_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/main.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class BlocInit extends StatelessWidget {
  const BlocInit({super.key});

  @override
  Widget build(BuildContext context) {
    // push route when open notification and receive
    OneSignalUtils.setNotificationOpenedHandler(serviceLocator<AppRouter>());
    OneSignalUtils.setNotificationReceivedHandler(serviceLocator<AppRouter>());

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) => p.userException != c.userException,
      listener: (context, state) {
        if (state.isUserCode404()) {
          serviceLocator<AppRouter>().root.popUntilRoot();
          serviceLocator<AppRouter>().root.replace(const CreateUserPageRoute());
        }
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStateStatus.logout) {
            serviceLocator<AppRouter>().root.popUntilRoot();
            serviceLocator<AppRouter>().root.replace(const LoginPageRoute());
          }
          if (state.goOnCreateUserPage) {
            serviceLocator<AppRouter>().root.popUntilRoot();
            serviceLocator<AppRouter>()
                .root
                .replace(const CreateUserPageRoute());
          }
        },
        buildWhen: (p, c) =>
            p.currentUser.authId != c.currentUser.authId || p.token != c.token,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: HomeEventCubit(
                  privateEventUseCases: serviceLocator(param1: state),
                  notificationCubit: serviceLocator(),
                ),
              ),
              BlocProvider.value(
                value: ImprintCubit(
                  imprintUseCases: serviceLocator(),
                  notificationCubit: serviceLocator(),
                ),
              ),
              BlocProvider.value(
                value: ChatCubit(
                  chatUseCase: serviceLocator(param1: state),
                  notificationCubit: serviceLocator(),
                ),
              ),
              BlocProvider.value(
                value: LocationCubit(
                  locationUseCases: serviceLocator(),
                  notificationCubit: serviceLocator(),
                ),
              ),
              BlocProvider.value(
                value: ImageCubit(
                  imagePickerUseCases: serviceLocator(),
                  notificationCubit: serviceLocator(),
                ),
              ),
            ],
            child: App(authState: state),
          );
        },
      ),
    );
  }
}
