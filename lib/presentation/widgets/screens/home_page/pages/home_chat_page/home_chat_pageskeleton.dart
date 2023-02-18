import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomeChatPageSkeleton extends StatelessWidget {
  const HomeChatPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonListView(
      itemBuilder: (p0, p1) {
        return SkeletonListTile(
          contentSpacing: 0,
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
