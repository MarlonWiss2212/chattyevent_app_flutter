import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class ProfilePageScaffold extends StatelessWidget {
  final String userId;
  const ProfilePageScaffold({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
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
        UserEntity? foundUser = BlocProvider.of<UserCubit>(context).getUserById(
          userId: userId,
        );
        Widget body;
        if (state is ProfilePageLoading) {
          body = Center(child: PlatformCircularProgressIndicator());
        } else {
          if (foundUser == null) {
            body = Center(
              child: PlatformTextButton(
                child: Text("Keinen User mit der Id: $userId"),
                onPressed: () =>
                    BlocProvider.of<ProfilePageCubit>(context).getOneUserViaApi(
                  getOneUserFilter: GetOneUserFilter(id: userId),
                ),
              ),
            );
          } else {
            body = UserProfileDataPage(user: foundUser);
          }
        }

        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(
              foundUser != null
                  ? foundUser.username ?? "Profilseite"
                  : "Profilseite",
            ),
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
    ;
  }
}
