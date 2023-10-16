import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              AutoRouter.of(context).push(
                const EventUpdatePermissionsRoute(),
              );
            },
            child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.security,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "eventPage.tabs.infoTab.memberPermissionsText",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ).tr()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
