import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_user_list/private_event_tab_user_list_item.dart';

class PrivateEventTabUserListDetail extends StatelessWidget {
  const PrivateEventTabUserListDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        final currentPrivatEventUser = state.privateEventUsers.firstWhereOrNull(
          (element) =>
              element.user.id ==
              BlocProvider.of<AuthCubit>(context).state.currentUser.id,
        );

        return SliverList(
          delegate: SliverChildListDelegate(
            [
              Center(
                child: Text(
                  "Mitglieder die da sein werden: ${state.privateEvent.users?.where((element) => element.status == "accepted").length.toString()}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              if (currentPrivatEventUser != null &&
                  state.privateEvent.groupchatTo == null &&
                  currentPrivatEventUser.privateEventUser.organizer !=
                      false) ...{
                ListTile(
                  leading: const Icon(
                    Icons.person_add,
                    color: Colors.green,
                  ),
                  title: const Text(
                    "User zum Event hinzufügen",
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {
                    AutoRouter.of(context).push(
                      const PrivateEventInviteUserPageRoute(),
                    );
                  },
                )
              },
              if (state.privateEventUsers.isEmpty &&
                  state.loadingPrivateEvent) ...[
                SkeletonListTile(
                  padding: const EdgeInsets.all(8),
                  hasSubtitle: true,
                  titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                  subtitleStyle: const SkeletonLineStyle(
                      width: double.infinity, height: 16),
                  leadingStyle: const SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                  ),
                ),
              ] else if (state.privateEventUsers.isNotEmpty) ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PrivateEventTabUserListItem(
                      currentPrivatEventUser: currentPrivatEventUser,
                      privateEventUser: state.privateEventUsers[index],
                    );
                  },
                  itemCount: state.privateEventUsers.length,
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
