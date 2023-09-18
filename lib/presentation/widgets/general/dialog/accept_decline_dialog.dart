import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

class AcceptDeclineDialog extends StatelessWidget {
  final String title;
  final String message;
  final void Function()? onYesPress;
  final void Function()? onNoPress;

  const AcceptDeclineDialog({
    super.key,
    required this.message,
    required this.title,
    this.onNoPress,
    this.onYesPress,
  });

  @override
  Widget build(BuildContext context) {
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
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.clip,
                    ).tr(),
                    const SizedBox(height: 8),
                    Text(
                      message,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.clip,
                    ).tr(),
                  ],
                ),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Button(onTap: onNoPress, text: "Nein"),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 1,
                    child: Button(onTap: onYesPress, text: "Ja"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
