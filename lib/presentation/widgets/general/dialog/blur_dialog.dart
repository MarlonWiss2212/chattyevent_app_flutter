import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BlurDialog extends StatelessWidget {
  final Widget child;
  const BlurDialog({
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
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Dialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Ionicons.close),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
