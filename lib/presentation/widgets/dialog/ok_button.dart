import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class OKButton extends StatelessWidget {
  const OKButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformTextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text("OK"),
    );
  }
}
