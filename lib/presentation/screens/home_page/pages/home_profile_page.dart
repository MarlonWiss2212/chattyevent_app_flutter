import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        Widget body;

        if (state.currentUser.id != "") {
          body = UserProfileDataPage(user: state.currentUser);
        } else if (state.status == AuthStateStatus.loading &&
            state.currentUser.id == "") {
          body = Center(child: PlatformCircularProgressIndicator());
        } else {
          body = Center(
            child: PlatformTextButton(
              child: Text(
                  "Keinen User mit der Id: ${serviceLocator<FirebaseAuth>().currentUser?.uid}"),
              onPressed: () => BlocProvider.of<AuthCubit>(context)
                  .setCurrentUserFromFirebaseViaApi(),
            ),
          );
        }

        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: Hero(
              tag: "${state.currentUser.id} username",
              child: Text(
                state.currentUser.username ?? "Profilseite",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            trailingActions: [
              IconButton(
                onPressed: () => AutoRouter.of(context).push(
                  const SettingsWrapperPageRoute(),
                ),
                icon: Icon(PlatformIcons(context).settings),
              )
            ],
          ),
          body: Column(
            children: [
              if (state.status == AuthStateStatus.loading &&
                  state.currentUser.id != "") ...{
                const LinearProgressIndicator()
              },
              Expanded(child: body),
            ],
          ),
        );
      },
    );
  }
}
