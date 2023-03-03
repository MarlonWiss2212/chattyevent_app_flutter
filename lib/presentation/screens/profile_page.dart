import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  final UserEntity? userToSet;
  final bool loadUserFromApiToo;

  const ProfilePage({
    super.key,
    this.loadUserFromApiToo = true,
    this.userToSet,
    @PathParam('id') required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageCubit(
        ProfilePageInitial(
          user: userToSet ?? UserEntity(id: "", authId: ""),
        ),
        userUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        userCubit: BlocProvider.of<UserCubit>(context),
      ),
      child: Builder(builder: (context) {
        if (userToSet == null || loadUserFromApiToo) {
          BlocProvider.of<ProfilePageCubit>(context).getOneUserViaApi(
            getOneUserFilter: GetOneUserFilter(id: userId),
          );
        }

        return BlocConsumer<ProfilePageCubit, ProfilePageState>(
          listener: (context, state) async {
            if (state is ProfilePageError) {
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
            } else if (state is ProfilePageLoading && state.user.id == "") {
              body = Center(child: PlatformCircularProgressIndicator());
            } else {
              body = Center(
                child: PlatformTextButton(
                  child: Text("Keinen User mit der Id: $userId"),
                  onPressed: () => BlocProvider.of<ProfilePageCubit>(context)
                      .getOneUserViaApi(
                    getOneUserFilter: GetOneUserFilter(id: userId),
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
              ),
              body: Column(
                children: [
                  if (state is ProfilePageLoading && state.user.id != "") ...{
                    const LinearProgressIndicator()
                  },
                  Expanded(child: body),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
