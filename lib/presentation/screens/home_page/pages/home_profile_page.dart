import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/profile/user_profile_data_page.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthCubit>(context).state as AuthLoaded;

    BlocProvider.of<UserCubit>(context).getOneUser(
      getOneUserFilter: GetOneUserFilter(
        id: authState.userAndToken.user.id,
      ),
    );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
        /*  trailingActions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logout();

              BlocProvider.of<ChatCubit>(context).reset();
              BlocProvider.of<AddChatCubit>(context).reset();
              BlocProvider.of<EditChatCubit>(context).reset();
              BlocProvider.of<MessageCubit>(context).reset();
              BlocProvider.of<PrivateEventCubit>(context).reset();
              BlocProvider.of<AddPrivateEventCubit>(context).reset();
              BlocProvider.of<EditPrivateEventCubit>(context).reset();
              BlocProvider.of<UserCubit>(context).reset();
              BlocProvider.of<UserSearchCubit>(context).reset();

              AutoRouter.of(context).popUntilRoot();
              AutoRouter.of(context).replace(const LoginPageRoute());
            },
            icon: const Icon(Icons.logout),
          ),
        ],*/
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserStateLoaded) {
            UserEntity? foundUser;
            for (final user in state.users) {
              if (user.id == authState.userAndToken.user.id) {
                foundUser = user;
              }
            }

            if (foundUser == null) {
              return Center(
                child: PlatformTextButton(
                  child: const Text("Keinen User gefunden"),
                  onPressed: () =>
                      BlocProvider.of<UserCubit>(context).getOneUser(
                    getOneUserFilter: GetOneUserFilter(
                      id: authState.userAndToken.user.id,
                    ),
                  ),
                ),
              );
            }

            return UserProfileDataPage(user: foundUser);
          } else if (state is UserStateLoading) {
            return Center(child: PlatformCircularProgressIndicator());
          } else {
            return Center(
              child: PlatformTextButton(
                child: Text(
                  state is UserStateError ? state.message : "User laden",
                ),
                onPressed: () => BlocProvider.of<UserCubit>(context).getOneUser(
                  getOneUserFilter: GetOneUserFilter(
                    id: authState.userAndToken.user.id,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
