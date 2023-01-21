import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/profile_page_scaffold.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  final bool loadUser;
  const ProfilePage({
    super.key,
    @PathParam('id') required this.userId,
    this.loadUser = true,
  });

  @override
  Widget build(BuildContext context) {
    if (loadUser) {
      BlocProvider.of<ProfilePageCubit>(context).getOneUserViaApi(
        getOneUserFilter: GetOneUserFilter(id: userId),
      );
    }

    return ProfilePageScaffold(userId: userId);
  }
}
