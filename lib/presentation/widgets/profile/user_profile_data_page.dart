import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';

class UserProfileDataPage extends StatelessWidget {
  final UserEntity user;
  const UserProfileDataPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            children: [
              // Profile Image
              Container(
                width: min(size.width / 3, 150),
                height: min(size.width / 3, 150),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100000000000000),
                  ),
                ),
              ),
              // name
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  user.username ?? "Kein Benutzername",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
