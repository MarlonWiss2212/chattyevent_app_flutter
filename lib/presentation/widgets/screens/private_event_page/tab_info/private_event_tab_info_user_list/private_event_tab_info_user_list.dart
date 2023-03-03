import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_user_list/private_event_tab_info_user_list_item.dart';

class PrivateEventTabInfoUserList extends StatelessWidget {
  const PrivateEventTabInfoUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              "Mitglieder die da sein werden: ${state.privateEvent.users?.where((element) => element.status == "accapted").length.toString()}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (state.privateEventUsers.isEmpty &&
                state.loadingPrivateEvent) ...[
              const SizedBox(height: 8),
              SkeletonListTile(
                padding: const EdgeInsets.all(8),
                hasSubtitle: true,
                titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                subtitleStyle:
                    const SkeletonLineStyle(width: double.infinity, height: 16),
                leadingStyle: const SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                ),
              ),
            ] else if (state.privateEventUsers.isNotEmpty) ...[
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PrivateEventTabInfoUserListItem(
                    currentUserId:
                        BlocProvider.of<AuthCubit>(context).state.user?.uid ??
                            "",
                    privateEventUser: state.privateEventUsers[index],
                  );
                },
                itemCount: state.privateEventUsers.length,
              ),
            ]
          ],
        );
      },
    );
  }
}
