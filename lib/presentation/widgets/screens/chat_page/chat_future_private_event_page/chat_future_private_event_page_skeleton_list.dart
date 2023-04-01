import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skeletons/skeletons.dart';

class ChatFuturePrivateEventPageSkeletonList extends StatelessWidget {
  const ChatFuturePrivateEventPageSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonListView(
      spacing: 0,
      itemBuilder: (p0, p1) {
        return SkeletonListTile(
          hasSubtitle: true,
          titleStyle: const SkeletonLineStyle(width: 100, height: 22),
          subtitleStyle:
              const SkeletonLineStyle(width: double.infinity, height: 16),
          leadingStyle: const SkeletonAvatarStyle(
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
