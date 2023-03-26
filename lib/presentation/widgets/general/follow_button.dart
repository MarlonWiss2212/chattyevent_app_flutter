import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/button.dart';

class FollowButton extends StatelessWidget {
  final UserEntity user;
  final void Function()? onTap;
  const FollowButton({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (user.id == BlocProvider.of<AuthCubit>(context).state.currentUser.id) {
      return const SizedBox();
    }

    String text = "";
    TextStyle? textStyle;
    Color? color;

    if (user.myUserRelationToOtherUser?.statusOnRelatedUser == "follower") {
      text = "Follower";
      color = Colors.black;
      textStyle = Theme.of(context).textTheme.labelMedium?.apply(
            color: Colors.white,
          );
    } else if (user.myUserRelationToOtherUser?.statusOnRelatedUser ==
        "requestToFollow") {
      text = "Angefragt";
      color = Colors.black;
      textStyle = Theme.of(context).textTheme.labelMedium?.apply(
            color: Colors.white,
          );
    } else {
      text = "Folgen";
      color = Theme.of(context).colorScheme.primaryContainer;
      textStyle = Theme.of(context).textTheme.labelMedium?.apply(
            color: Colors.white,
          );
    }
    return Button(
      onTap: onTap,
      text: text,
      textStyle: textStyle,
      color: color,
    );
  }
}
