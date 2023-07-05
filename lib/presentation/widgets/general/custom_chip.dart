import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final Color color;
  final Icon? leadingIcon;
  final Text text;
  final void Function()? onTap;
  const CustomChip({
    super.key,
    required this.color,
    this.leadingIcon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: color,
              ),
              child: Row(
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    const SizedBox(width: 8),
                  ],
                  Flexible(child: text),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
