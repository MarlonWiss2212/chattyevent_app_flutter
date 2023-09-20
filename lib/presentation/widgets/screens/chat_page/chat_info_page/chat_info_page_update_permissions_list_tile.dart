import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_user/groupchat_user_role_enum.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ChatInfoPageUpdatePermissionsListTile extends StatelessWidget {
  const ChatInfoPageUpdatePermissionsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
        builder: (context, state) {
      if (state.getCurrentGroupchatUser()?.role !=
          GroupchatUserRoleEnum.admin) {
        return const SizedBox();
      }
      return ListTile(
        leading: const Icon(Icons.security),
        title: Text(
          "general.memberPermissionText",
          style: Theme.of(context).textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
        ).tr(),
        trailing: const Icon(Ionicons.chevron_forward),
        onTap: () {
          AutoRouter.of(context).push(
            const GroupchatUpdatePermissionsRoute(),
          );
        },
      );
    });
  }
}
