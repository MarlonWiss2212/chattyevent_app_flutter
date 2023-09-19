import 'package:chattyevent_app_flutter/core/enums/event/event_permission_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EventPermissionsMenu extends StatelessWidget {
  final String text;
  final void Function(EventPermissionEnum value) changePermission;
  final EventPermissionEnum? value;
  const EventPermissionsMenu({
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
                value: EventPermissionEnum.creatoronly,
                child: const Text(
                  "general.eventPermissionMenu.creatorOnlyText",
                ).tr(),
              ),
              PopupMenuItem(
                value: EventPermissionEnum.organizersonly,
                child: const Text(
                  "general.eventPermissionMenu.organizerOnlyText",
                ).tr(),
              ),
              PopupMenuItem(
                value: EventPermissionEnum.everyone,
                child: const Text("general.everyoneText").tr(),
              ),
            ],
            child: Row(
              children: [
                Text(
                  value == null
                      ? "general.defaultDataText"
                      : value == EventPermissionEnum.creatoronly
                          ? "general.eventPermissionMenu.creatorOnlyText"
                          : value == EventPermissionEnum.organizersonly
                              ? "general.eventPermissionMenu.organizerOnlyText"
                              : value == EventPermissionEnum.everyone
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
