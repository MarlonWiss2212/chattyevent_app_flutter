import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/request_user_id_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_list_tile.dart';

class ProfileFollowRequestsTab extends StatelessWidget {
  const ProfileFollowRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      listener: (context, state) async {
        if (state.followRequestsError != null &&
            state.followRequestsStatus ==
                ProfilePageStateFollowRequestsStatus.error) {
          return await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text(state.followRequestsError!.title),
                content: Text(state.followRequestsError!.message),
                actions: const [OKButton()],
              );
            },
          );
        }
      },
      //  buildWhen: (previous, current) =>
      //      previous.userRelations?.length != current.userRelations?.length,
      builder: (context, state) {
        if (state.followRequests == null) {
          return const Center(
            child: Text("Keine Relationen"),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return UserListTile(
              user: state.followRequests![index],
              trailing: InkWell(
                onTap: () {
                  BlocProvider.of<ProfilePageCubit>(context)
                      .acceptFollowRequest(
                    requestUserIdFilter: RequestUserIdFilter(
                      requesterUserId: state.followRequests![index].id,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Ink(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Text(
                      "Akzeptieren",
                      style: Theme.of(context).textTheme.labelMedium?.apply(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: state.followRequests!.length,
        );
      },
    );
  }
}
