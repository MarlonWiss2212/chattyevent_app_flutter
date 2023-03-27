import 'dart:math';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class EventHorizontalListSkeleton extends StatelessWidget {
  const EventHorizontalListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    // this is the function from the item to get the width
    double viewportFraction = min(
      (300 / MediaQuery.of(context).size.width).toDouble(),
      1,
    );
    final width = (MediaQuery.of(context).size.width * viewportFraction) - 16;
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
