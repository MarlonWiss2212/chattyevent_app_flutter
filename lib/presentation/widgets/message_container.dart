import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
    this.fileLink,
    required this.title,
    required this.date,
    required this.content,
    required this.alignStart,
  });

  final String? fileLink;
  final String title;
  final String date;
  final String content;
  final bool alignStart;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          alignStart ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.1,
          ),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: alignStart
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            color: alignStart
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  const SizedBox(width: 8),
                  Text(date),
                ],
              ),
              if (fileLink != null) ...{
                Image.network(
                  fileLink!,
                  fit: BoxFit.contain,
                )
              },
              Text(
                content,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
