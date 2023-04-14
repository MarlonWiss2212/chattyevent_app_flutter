import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';

class HomeProfilePage extends StatelessWidget {
  final String? userId;

  const HomeProfilePage({
    super.key,
    @PathParam('id') this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageCubit(
        ProfilePageState(
          user: BlocProvider.of<AuthCubit>(context).state.currentUser,
        ),
        userUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        userRelationUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
        authCubit: BlocProvider.of<AuthCubit>(context),
      ),
      child: Builder(
        builder: (context) {
          BlocProvider.of<ProfilePageCubit>(context).getCurrentUserViaApi();
          return const AutoRouter();
        },
      ),
    );
  }
}
