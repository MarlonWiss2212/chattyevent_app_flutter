import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

class CustomAlertDialog extends StatelessWidget {
  final NotificationAlert notificationAlert;
  final BuildContext context;
  const CustomAlertDialog({
    super.key,
    required this.notificationAlert,
    required this.context,
  });

  @override
  Widget build(BuildContext c) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 10,
      shadowColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    Text(
                      notificationAlert.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notificationAlert.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              Button(
                onTap: () => Navigator.of(c).pop(),
                text: "general.okText".tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
