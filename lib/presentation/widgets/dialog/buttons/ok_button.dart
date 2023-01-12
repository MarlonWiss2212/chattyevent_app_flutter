import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class OKButton extends StatelessWidget {
  final double? width;
  const OKButton({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: PlatformTextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("OK"),
      ),
    );
  }
}
