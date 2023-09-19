import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GroupchatPermissionsMenu extends StatelessWidget {
  final String text;
  final void Function(GroupchatPermissionEnum value) changePermission;
  final GroupchatPermissionEnum? value;
  const GroupchatPermissionsMenu({
    super.key,
    required this.text,
    required this.changePermission,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ).tr(),
          PopupMenuButton(
            initialValue: value,
            onSelected: changePermission,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: GroupchatPermissionEnum.adminsonly,
                child: const Text(
                  "general.groupchatPermissionMenu.onlyAdminsText",
                ).tr(),
              ),
              PopupMenuItem(
                value: GroupchatPermissionEnum.everyone,
                child: const Text("general.everyoneText").tr(),
              ),
            ],
            child: Row(
              children: [
                Text(
                  value == null
                      ? "general.defaultDataText"
                      : value == GroupchatPermissionEnum.adminsonly
                          ? "general.groupchatPermissionMenu.onlyAdminsText"
                          : value == GroupchatPermissionEnum.everyone
                              ? "general.everyoneText"
                              : "general.noInfoText",
                ).tr(),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, size: 14)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
