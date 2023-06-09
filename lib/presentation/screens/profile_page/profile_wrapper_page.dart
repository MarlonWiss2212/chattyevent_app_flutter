import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

class ProfileWrapperPage extends StatelessWidget {
  final String userId;
  final UserEntity userToSet;

  const ProfileWrapperPage({
    super.key,
    required this.userToSet,
    @PathParam('id') required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageCubit(
        ProfilePageState(user: userToSet),
        userRelationUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        userUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        authCubit: BlocProvider.of<AuthCubit>(context),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      )..getCurrentUserViaApi(),
      child: HeroControllerScope(
        controller: HeroController(),
        child: const AutoRouter(),
      ),
    );
  }
}
