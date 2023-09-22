import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/circle_image/cirlce_image.dart';

class MiniProfileImage extends StatelessWidget {
  const MiniProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) =>
          p.currentUser.profileImageLink != c.currentUser.profileImageLink ||
          p.currentUser.userRelationCounts?.followRequestCount !=
              c.currentUser.userRelationCounts?.followRequestCount,
      builder: (context, state) {
        return Badge(
          isLabelVisible:
              state.currentUser.userRelationCounts?.followRequestCount != null,
          backgroundColor: Theme.of(context).colorScheme.primary,
          label:
              state.currentUser.userRelationCounts?.followRequestCount != null
                  ? Text(
                      state.currentUser.userRelationCounts!.followRequestCount!
                          .toString(),
                    )
                  : null,
          child: CircleImage(
            height: 24,
            width: 24,
            imageLink: state.currentUser.profileImageLink,
          ),
        );
      },
    );
  }
}
