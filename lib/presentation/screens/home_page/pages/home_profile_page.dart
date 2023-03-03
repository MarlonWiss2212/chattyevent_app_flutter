import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/current_user_cubit.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentUserCubit, CurrentUserState>(
      bloc: BlocProvider.of<CurrentUserCubit>(context)
        ..getOneUserViaApi(
          getOneUserFilter: GetOneUserFilter(
            authId: serviceLocator<FirebaseAuth>().currentUser?.uid,
          ),
        ),
      listener: (context, state) async {
        if (state.status == CurrentUserStateStatus.error &&
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
      builder: (context, state) {
        Widget body;

        if (state.user.id != "") {
          body = UserProfileDataPage(user: state.user);
        } else if (state.status == CurrentUserStateStatus.loading &&
            state.user.id == "") {
          body = Center(child: PlatformCircularProgressIndicator());
        } else {
          body = Center(
            child: PlatformTextButton(
              child: Text(
                  "Keinen User mit der Id: ${serviceLocator<FirebaseAuth>().currentUser?.uid}"),
              onPressed: () =>
                  BlocProvider.of<CurrentUserCubit>(context).getOneUserViaApi(
                getOneUserFilter: GetOneUserFilter(
                  authId: serviceLocator<FirebaseAuth>().currentUser?.uid,
                ),
              ),
            ),
          );
        }

        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: Hero(
              tag: "${state.user.id} username",
              child: Text(
                state.user.username ?? "Profilseite",
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
              if (state.status == CurrentUserStateStatus.loading &&
                  state.user.id != "") ...{const LinearProgressIndicator()},
              Expanded(child: body),
            ],
          ),
        );
      },
    );
  }
}
