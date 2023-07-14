import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
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
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedSize(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: widget.onTap,
          child: IntrinsicWidth(
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: widget.color,
              ),
              child: Row(
                children: [
                  if (widget.leadingIcon != null) ...[
                    widget.leadingIcon!,
                    const SizedBox(width: 8),
                  ],
                  Flexible(child: widget.text),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
