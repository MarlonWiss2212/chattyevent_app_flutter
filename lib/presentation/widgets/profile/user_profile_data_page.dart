import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

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
            const SizedBox(height: 40),
            // Profile Image

            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            ),
            const SizedBox(height: 20),
            // name
            Hero(
              tag: "${user.id} username",
              child: Text(
                user.username ?? "Kein Benutzername",
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
