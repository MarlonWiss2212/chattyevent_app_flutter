import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_grid_list_item.dart';

class SelectedUsersList extends StatelessWidget {
  final List<UserEntity> users;
  final void Function(UserEntity user)? onPress;
  const SelectedUsersList({
    super.key,
    required this.users,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 70,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 70,
                      height: 70,
                      child: UserGridListItem(
                        user: users[index],
                        onPress: () =>
                            onPress != null ? onPress!(users[index]) : null,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: users.length,
                ),
              ),
              const SizedBox(width: 8),
              Text(users.length.toString())
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
