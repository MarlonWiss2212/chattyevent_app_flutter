import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class ProfileFollowerTab extends StatelessWidget {
  const ProfileFollowerTab({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfilePageCubit>(context).getFollowers();

    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      listener: (context, state) async {
        if (state.followersError != null &&
            state.followersStatus == ProfilePageStateFollowersStatus.error) {
          return await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text(state.followersError!.title),
                content: Text(state.followersError!.message),
                actions: const [OKButton()],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.followers == null) {
          return const Center(
            child: Text("Keine Relationen"),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return UserListTile(
              user: state.followers![index],
            );
          },
          itemCount: state.followers!.length,
        );
      },
    );
  }
}
