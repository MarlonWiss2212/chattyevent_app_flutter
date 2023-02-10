import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/auth/current_user_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = Jwt.parseJwt(
        (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token)["sub"];

    return BlocConsumer<CurrentUserCubit, CurrentUserState>(
      bloc: BlocProvider.of<CurrentUserCubit>(context)
        ..getOneUserViaApi(
          getOneUserFilter: GetOneUserFilter(id: currentUserId),
        ),
      listener: (context, state) async {
        if (state is CurrentUserError) {
          return await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text(state.title),
                content: Text(state.message),
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
        } else if (state.loadingUser && state.user.id == "") {
          body = Center(child: PlatformCircularProgressIndicator());
        } else {
          body = Center(
            child: PlatformTextButton(
              child: Text("Keinen User mit der Id: $currentUserId"),
              onPressed: () =>
                  BlocProvider.of<CurrentUserCubit>(context).getOneUserViaApi(
                getOneUserFilter: GetOneUserFilter(id: currentUserId),
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
              if (state.loadingUser && state.user.id != "") ...{
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
