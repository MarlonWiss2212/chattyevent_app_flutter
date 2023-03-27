import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_search_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/follow_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_grid_list_item.dart';

class UserHorizontalList extends StatelessWidget {
  final List<UserEntity> users;
  const UserHorizontalList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    double viewportFraction = min(
      (175 / MediaQuery.of(context).size.width).toDouble(),
      1,
    );
    final pageController = PageController(viewportFraction: viewportFraction);
    final width = (MediaQuery.of(context).size.width * viewportFraction) - 16;
    final height = width * 1.2;

    return SizedBox(
      height: height,
      child: PageView.builder(
        padEnds: false,
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        itemBuilder: (context, index) {
          return FractionallySizedBox(
            widthFactor: .95,
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: height,
              child: UserGridListItem(
                user: users[index],
                button: FollowButton(
                  user: users[index],
                  onTap: () {
                    BlocProvider.of<UserSearchCubit>(context)
                        .followOrUnfollowUserViaApi(
                      user: users[index],
                    );
                  },
                ),
                onPress: () {
                  AutoRouter.of(context).push(
                    ProfileWrapperPageRoute(
                      userId: users[index].id,
                      userToSet: users[index],
                      loadUserFromApiToo: true,
                    ),
                  );
                },
              ),
            ),
          );
        },
        itemCount: users.length,
      ),
    );
  }
}
