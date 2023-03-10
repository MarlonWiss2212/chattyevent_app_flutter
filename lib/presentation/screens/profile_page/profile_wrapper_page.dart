import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

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
        userUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        userCubit: BlocProvider.of<UserCubit>(context),
        auth: serviceLocator<FirebaseAuth>(),
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
                return await showPlatformDialog(
                  context: context,
                  builder: (context) {
                    return PlatformAlertDialog(
                      title: Text(state.error!.title),
                      content: Text(state.error!.message),
                      actions: const [OKButton()],
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
