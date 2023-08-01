import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/calendar/calendar_status_enum.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeletons/skeletons.dart';

class NewEventDateTabCalendarUserList extends StatelessWidget {
  const NewEventDateTabCalendarUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventCubit, AddEventState>(
      builder: (context, state) {
        return Expanded(
          child: state.loadingCalendarTimeUsers
              ? SkeletonListView(
                  spacing: 0,
                  itemBuilder: (p0, p1) {
                    return SkeletonListTile(
                      hasSubtitle: true,
                      titleStyle:
                          const SkeletonLineStyle(width: 100, height: 22),
                      subtitleStyle: const SkeletonLineStyle(
                          width: double.infinity, height: 16),
                      leadingStyle: const SkeletonAvatarStyle(
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Icon? trailing;
                    Color? color;
                    if (state.calendarTimeUsers[index].status ==
                        CalendarStatusEnum.doesnothavetime) {
                      trailing = const Icon(
                        Ionicons.close,
                        color: Colors.white,
                        size: 20,
                      );
                      color = Colors.red;
                    } else if (state.calendarTimeUsers[index].status ==
                        CalendarStatusEnum.hastime) {
                      trailing = const Icon(
                        Ionicons.checkmark,
                        color: Colors.white,
                        size: 20,
                      );
                      color = Colors.green;
                    } else {
                      trailing = const Icon(
                        Ionicons.remove,
                        color: Colors.white,
                        size: 20,
                      );
                      color = Colors.grey[800];
                    }

                    return UserListTile(
                      key: ObjectKey(state.calendarTimeUsers[index]),
                      user: state.calendarTimeUsers[index],
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: trailing,
                        ),
                      ),
                    );
                  },
                  itemCount: state.calendarTimeUsers.length,
                ),
        );
      },
    );
  }
}
