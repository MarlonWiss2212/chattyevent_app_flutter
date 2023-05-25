import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () => Navigator.of(context).pop(),
      child: const Icon(
        Icons.arrow_back_ios_new,
        size: 20,
      ),
    );
  }
}
