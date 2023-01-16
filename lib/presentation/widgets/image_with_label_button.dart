import 'package:flutter/material.dart';

class ImageWithLabelButton extends StatelessWidget {
  final void Function()? onTap;
  final String? imageLink;
  final String label;

  const ImageWithLabelButton({
    super.key,
    this.onTap,
    this.imageLink,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:
                  imageLink != null ? NetworkImage(imageLink!) : null,
              backgroundColor: imageLink == null
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
