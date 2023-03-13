import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class ProfileFollowedTab extends StatelessWidget {
  const ProfileFollowedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      listener: (context, state) async {
        if (state.followedError != null &&
            state.followedStatus == ProfilePageStateFollowedStatus.error) {
          return await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text(state.followedError!.title),
                content: Text(state.followedError!.message),
                actions: const [OKButton()],
              );
            },
          );
        }
      },
      //   buildWhen: (previous, current) =>
      //       previous.userRelations?.length != current.userRelations?.length,
      builder: (context, state) {
        if (state.followed == null) {
          return const Center(
            child: Text("Keine Relationen"),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return UserListTile(
              user: state.followed![index],
            );
          },
          itemCount: state.followed!.length,
        );
      },
    );
  }
}
