import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_connected_groupchat/event_tab_info_connected_groupchat_tile.dart';

class EventTabInfoGroupchatTo extends StatelessWidget {
  const EventTabInfoGroupchatTo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        if (state.groupchat != null || state.loadingGroupchat) {
          return Column(
            children: [
              const CustomDivider(),
              if (state.groupchat != null) ...{
                EventTabInfoGroupchatToTile(groupchat: state.groupchat!)
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