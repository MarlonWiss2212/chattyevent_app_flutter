import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_page_circle_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/profile_page/profile_page_follower_counts.dart';

class ProfilePageData extends StatelessWidget {
  const ProfilePageData({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          children: const [
            SizedBox(height: 20),
            ProfilePageCircleImage(),
            SizedBox(height: 20),
            ProfileFollowerCounts(),
          ],
        ),
      ),
    );
  }
}
