import 'package:flutter/widgets.dart';
import 'package:skeletons/skeletons.dart';

class ProfileFollowersTabSkeletonListView extends StatelessWidget {
  const ProfileFollowersTabSkeletonListView({super.key});

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
