import 'package:chattyevent_app_flutter/core/enums/user_relation/user_relation_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

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
    TextStyle? textStyle = Theme.of(context).textTheme.labelMedium;
    Color? color;

    if (user.myUserRelationToOtherUser?.statusOnRelatedUser ==
        UserRelationStatusEnum.follower) {
      text = "Gefolgt";
      color = Theme.of(context).colorScheme.surface;
    } else if (user.myUserRelationToOtherUser?.statusOnRelatedUser ==
        UserRelationStatusEnum.requesttofollow) {
      text = "Angefragt";
      color = Theme.of(context).colorScheme.surface;
    } else {
      text = "Folgen";
      color = Theme.of(context).colorScheme.primaryContainer;
    }
    return Button(
      onTap: onTap,
      text: text,
      textStyle: textStyle,
      color: color,
    );
  }
}
