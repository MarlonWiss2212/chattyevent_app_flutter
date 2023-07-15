import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_permission_enum.dart';
import 'package:flutter/material.dart';

class PrivateEventPermissionsMenu extends StatelessWidget {
  final String text;
  final void Function(PrivateEventPermissionEnum value) changePermission;
  final PrivateEventPermissionEnum? value;
  const PrivateEventPermissionsMenu({
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
            onSelected: changePermission,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: PrivateEventPermissionEnum.createronly,
                child: Text("Nur Ersteller"),
              ),
              PopupMenuItem(
                value: PrivateEventPermissionEnum.organizersonly,
                child: Text("Nur Organisatoren"),
              ),
              PopupMenuItem(
                value: PrivateEventPermissionEnum.everyone,
                child: Text("Alle"),
              ),
            ],
            child: Row(
              children: [
                Text(
                  value == null
                      ? "Standarddaten"
                      : value == PrivateEventPermissionEnum.createronly
                          ? "Nur Ersteller"
                          : value == PrivateEventPermissionEnum.organizersonly
                              ? "Nur Organisatoren"
                              : value == PrivateEventPermissionEnum.everyone
                                  ? "Alle"
                                  : "Keine Info",
                ),
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
