import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_connected_groupchat/private_event_tab_info_connected_groupchat_tile.dart';

class PrivateEventTabInfoGroupchatTo extends StatelessWidget {
  const PrivateEventTabInfoGroupchatTo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      buildWhen: (previous, current) {
        if (previous.groupchat != current.groupchat) {
          return true;
        }
        if (previous.groupchat?.id != current.groupchat?.id) {
          return true;
        }
        if (previous.loadingGroupchat != current.loadingGroupchat) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state.groupchat != null || state.loadingGroupchat) {
          return Column(
            children: [
              Text(
                "Verbundener Gruppenchat: ",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (state.groupchat != null) ...{
                PrivateEventTabInfogroupchatToTile(
                  groupchat: state.groupchat!,
                )
              } else ...{
                SkeletonListTile(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  hasSubtitle: true,
                  titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                  subtitleStyle: const SkeletonLineStyle(
                    width: double.infinity,
                    height: 16,
                  ),
                  leadingStyle: const SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                  ),
                )
              },
            ],
          );
        }
        return Container();
      },
    );
  }
}

/*
*/