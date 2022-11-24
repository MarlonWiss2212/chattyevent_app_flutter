import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer(
      {super.key,
      required this.title,
      required this.date,
      required this.subtitle});

  final String title;
  final String date;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size.width * 0.8),
          child: ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(date),
              ],
            ),
            subtitle: Text(subtitle),
            tileColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        const Expanded(child: Text(""))
      ],
    );
  }
}
