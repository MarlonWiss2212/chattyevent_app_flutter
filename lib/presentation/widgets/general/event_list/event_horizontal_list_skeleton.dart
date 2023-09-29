import 'dart:math';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class EventHorizontalListSkeleton extends StatelessWidget {
  const EventHorizontalListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 16;
    final double viewportFraction = min(
      (350 / screenWidth).toDouble(),
      1,
    );
    final width = screenWidth * viewportFraction;
    final height = width / 4 * 3;

    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(width: width, height: height),
            ),
            const SizedBox(height: 8),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(width: width, height: height),
            ),
          ],
        ),
      ),
    );
  }
}
