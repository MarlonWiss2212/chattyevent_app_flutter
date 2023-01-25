import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_profile_page/home_profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  const ProfilePage({
    super.key,
    @PathParam('id') required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      bloc: BlocProvider.of<ProfilePageCubit>(context)
        ..getOneUserViaApi(
          getOneUserFilter: GetOneUserFilter(id: userId),
        ),
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
        if (state is ProfilePageLoading) {
          body = Center(child: PlatformCircularProgressIndicator());
        } else {
          if (state is ProfilePageStateWithUser) {
            body = UserProfileDataPage(user: state.user);
          } else {
            body = Center(
              child: PlatformTextButton(
                child: Text("Keinen User mit der Id: $userId"),
                onPressed: () =>
                    BlocProvider.of<ProfilePageCubit>(context).getOneUserViaApi(
                  getOneUserFilter: GetOneUserFilter(id: userId),
                ),
              ),
            );
          }
        }

        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(
              state is ProfilePageStateWithUser
                  ? state.user.username ?? "Profilseite"
                  : "Profilseite",
            ),
            trailingActions: /* trailing == true
                ? [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<ChatCubit>(context).reset();
                        BlocProvider.of<AddChatCubit>(context).reset();
                        BlocProvider.of<CurrentChatCubit>(context).reset();
                        BlocProvider.of<MessageCubit>(context).reset();
                        BlocProvider.of<PrivateEventCubit>(context).reset();
                        BlocProvider.of<AddPrivateEventCubit>(context).reset();
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .reset();
                        BlocProvider.of<UserCubit>(context).reset();
                        BlocProvider.of<UserSearchCubit>(context).reset();
                        BlocProvider.of<HomeMapPageCubit>(context).reset();
                        BlocProvider.of<UserSearchCubit>(context).reset();

                        BlocProvider.of<AuthCubit>(context).logout();

                        AutoRouter.of(context).popUntilRoot();
                        AutoRouter.of(context).replace(const LoginPageRoute());
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ]
                : []*/
                null,
          ),
          body: Column(
            children: [
              if (state is ProfilePageEditing) ...{
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
