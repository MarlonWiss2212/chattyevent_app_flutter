import 'dart:ui';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class BottomBlurredSurfaceDialog extends StatelessWidget {
  final Widget child;
  const BottomBlurredSurfaceDialog({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      resizeDuration: null,
      key: UniqueKey(),
      direction: DismissDirection.down,
      onDismissed: (direction) => Navigator.of(context).pop(),
      child: Dialog(
        alignment: Alignment.bottomCenter,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.topCenter,
              child: child,
            ),
          ),
        ).frosted(
          blur: 5,
          frostColor: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
