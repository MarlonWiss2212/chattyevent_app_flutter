import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class RequestHorizontalListSkeleton extends StatelessWidget {
  const RequestHorizontalListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkeletonAvatar(
      style: SkeletonAvatarStyle(),
    );
  }
}
