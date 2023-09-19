import 'package:flutter/material.dart';

class ChattyEventLogoAndTextAuthPages extends StatelessWidget {
  const ChattyEventLogoAndTextAuthPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/icon.png",
            width: 80,
            height: 80,
          ),
        ),
        Text(
          "ChattyEvent",
          style: Theme.of(context).textTheme.displayMedium,
          softWrap: true,
          overflow: TextOverflow.visible,
        )
      ],
    );
  }
}
