import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final Widget? trailing;

  const Button({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.trailing,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    const standardTextStyle = TextStyle(fontWeight: FontWeight.w700);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: [
                Text(
                  text,
                  style: textStyle != null
                      ? textStyle?.merge(
                            standardTextStyle,
                          ) ??
                          standardTextStyle
                      : standardTextStyle,
                ),
                if (trailing != null) ...{
                  Align(
                    alignment: Alignment.centerRight,
                    child: trailing,
                  )
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
