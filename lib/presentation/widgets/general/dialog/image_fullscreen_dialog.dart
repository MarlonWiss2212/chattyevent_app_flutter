import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ImageFullscreenDialog extends StatelessWidget {
  final String src;
  const ImageFullscreenDialog({
    super.key,
    required this.src,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.down,
      onDismissed: (direction) => Navigator.of(context).pop(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Flexible(
              child: Image.network(
                src,
                fit: BoxFit.contain,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.of(context).pop(),
                  child: Ink(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Ionicons.close),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
