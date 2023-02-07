import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';

class UserProfileDataPage extends StatelessWidget {
  final UserEntity user;
  const UserProfileDataPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Image
            CircleImage(
              imageLink: user.profileImageLink,
              heroTag: "${user.id} profileImage",
            ),
            const SizedBox(height: 20),
            // name
            //       Hero(
            //       tag: "${user.id} username",
            //       child: Text(
            //         user.username ?? "Kein Benutzername",
            //         style: Theme.of(context).textTheme.titleLarge,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //       ),
          ],
        ),
      ),
    );
  }
}
