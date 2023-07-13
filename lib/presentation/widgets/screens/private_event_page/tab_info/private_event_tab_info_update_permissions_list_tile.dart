import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class PrivateEventTabInfoUpdatePermissionsListTile extends StatelessWidget {
  const PrivateEventTabInfoUpdatePermissionsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        if (state.privateEvent.createdBy !=
            BlocProvider.of<AuthCubit>(context).state.currentUser.id) {
          return const SizedBox();
        }
        return ListTile(
          leading: const Icon(Icons.security),
          title: Text(
            "Mitglieder Berechtigungen",
            style: Theme.of(context).textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Ionicons.arrow_forward),
          onTap: () {
            AutoRouter.of(context).push(
              const PrivateEventUpdatePermissionsRoute(),
            );
          },
        );
      },
    );
  }
}
