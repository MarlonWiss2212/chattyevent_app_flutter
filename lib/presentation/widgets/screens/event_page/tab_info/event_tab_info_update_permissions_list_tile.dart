import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class EventTabInfoUpdatePermissionsListTile extends StatelessWidget {
  const EventTabInfoUpdatePermissionsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        if (state.event.createdBy !=
            BlocProvider.of<AuthCubit>(context).state.currentUser.id) {
          return const SizedBox();
        }
        return ListTile(
          leading: const Icon(Icons.security),
          title: Text(
            "eventPage.tabs.infoTab.memberPermissionsText",
            style: Theme.of(context).textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ).tr(),
          trailing: const Icon(Ionicons.chevron_forward),
          onTap: () {
            AutoRouter.of(context).push(
              const EventUpdatePermissionsRoute(),
            );
          },
        );
      },
    );
  }
}
