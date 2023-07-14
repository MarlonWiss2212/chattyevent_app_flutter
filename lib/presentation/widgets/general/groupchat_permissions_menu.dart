import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
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
            ),
            PopupMenuButton(
              initialValue: value,
              onSelected: (value) => changePermission(value),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value:GroupchatPermissionEnum.adminsonly,
                  child: Text("Nur Admins"),
                ),
                PopupMenuItem(
                  value: GroupchatPermissionEnum.everyone,
                  child: Text("Alle"),
                ),
              ],
              child: Row(
                children: [
                  Text(value == null
                      ? "Standarddaten"
                      : value == GroupchatPermissionEnum.adminsonly
                          ? "Nur Admins"
                          : value == GroupchatPermissionEnum.everyone
                              ? "Alle"
                              : "Keine Info",),
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
