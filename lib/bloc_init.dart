import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/location/location_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/image/image_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/main.dart';
import 'package:social_media_app_flutter/presentation/router/auth_guard.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class BlocInit extends StatelessWidget {
  const BlocInit({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter(authGuard: AuthGuard());

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.createUserPage) {
          appRouter.replace(const CreateUserPageRoute());
        }
      },
      bloc: BlocProvider.of<AuthCubit>(context)
        ..setCurrentUserFromFirebaseViaApi(),
      buildWhen: (previous, current) => previous.token != current.token,
      builder: (context, state) {
        final notificationCubit = BlocProvider.of<NotificationCubit>(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: UserSearchCubit(
                authCubit: BlocProvider.of<AuthCubit>(context),
                userRelationUseCases: serviceLocator(param1: state),
                userUseCases: serviceLocator(param1: state),
                notificationCubit: notificationCubit,
              ),
            ),
            BlocProvider.value(
              value: HomeEventCubit(
                privateEventUseCases: serviceLocator(param1: state),
                notificationCubit: notificationCubit,
              ),
            ),
            BlocProvider.value(
              value: ChatCubit(
                chatUseCases: serviceLocator(param1: state),
                notificationCubit: notificationCubit,
              ),
            ),
            BlocProvider.value(
              value: LocationCubit(
                locationUseCases: serviceLocator(),
                notificationCubit: notificationCubit,
              ),
            ),
            BlocProvider.value(
              value: ImageCubit(
                imagePickerUseCases: serviceLocator(),
                notificationCubit: notificationCubit,
              ),
            ),
          ],
          child: App(authState: state, appRouter: appRouter),
        );
      },
    );
  }
}
