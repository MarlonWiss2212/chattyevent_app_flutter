import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

class ProfileWrapperPage extends StatelessWidget {
  final String userId;
  final UserEntity? userToSet;
  final bool loadUserFromApiToo;

  const ProfileWrapperPage({
    super.key,
    this.loadUserFromApiToo = true,
    this.userToSet,
    @PathParam('id') required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageCubit(
        ProfilePageState(
          user: userToSet ?? UserEntity(id: userId, authId: ""),
        ),
        userRelationUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        userUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        userCubit: BlocProvider.of<UserCubit>(context),
        authCubit: BlocProvider.of<AuthCubit>(context),
      ),
      child: Builder(
        builder: (context) {
          if (userToSet == null || loadUserFromApiToo) {
            BlocProvider.of<ProfilePageCubit>(context).getCurrentUserViaApi();
          }
          return BlocListener<ProfilePageCubit, ProfilePageState>(
            listener: (context, state) async {
              if (state.status == ProfilePageStateStatus.error &&
                  state.error != null) {
                return await showDialog(
                  context: context,
                  builder: (c) {
                    return CustomAlertDialog(
                      message: state.error!.message,
                      title: state.error!.title,
                      context: c,
                    );
                  },
                );
              }
            },
            child: const AutoRouter(),
          );
        },
      ),
    );
  }
}
