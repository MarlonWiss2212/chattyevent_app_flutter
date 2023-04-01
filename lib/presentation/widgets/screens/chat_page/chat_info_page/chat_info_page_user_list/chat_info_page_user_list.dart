import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_user_list/chat_info_page_user_list_item.dart';

class ChatInfoPageUserList extends StatelessWidget {
  const ChatInfoPageUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              "Midglieder: ${state.users.length}",
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            if (state.getCurrentGroupchatUser()?.admin == true) ...{
              ListTile(
                leading: const Icon(
                  Icons.person_add,
                  color: Colors.green,
                ),
                title: const Text(
                  "User zum Chat hinzufügen",
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  AutoRouter.of(context).push(
                    ChatAddUserPageRoute(),
                  );
                },
              )
            },
            if (state.users.isEmpty && state.loadingChat) ...[
              SkeletonListTile(
                hasSubtitle: true,
                hasLeading: false,
                titleStyle: const SkeletonLineStyle(
                  width: double.infinity,
                  height: 22,
                ),
                subtitleStyle: const SkeletonLineStyle(
                  width: double.infinity,
                  height: 16,
                ),
              ),
            ] else if (state.users.isNotEmpty) ...{
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChatInfoPageUserListItem(
                    currentUser: state.getCurrentGroupchatUser() ??
                        UserWithGroupchatUserData(
                            id: BlocProvider.of<AuthCubit>(context)
                                .state
                                .currentUser
                                .id,
                            authId: BlocProvider.of<AuthCubit>(context)
                                .state
                                .currentUser
                                .authId),
                    user: state.users[index],
                  );
                },
                itemCount: state.users.length,
              ),
            }
          ],
        );
      },
    );
  }
}
