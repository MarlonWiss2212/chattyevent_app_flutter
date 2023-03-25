import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color? color;
  final TextStyle? textTheme;

  const Button({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Ink(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w700).merge(
                  textTheme,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
