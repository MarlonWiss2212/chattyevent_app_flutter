import 'package:flutter/material.dart';

class OKButton extends StatelessWidget {
  const OKButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text("OK"),
    );
  }
}
