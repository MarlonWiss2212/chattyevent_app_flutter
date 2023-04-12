import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_left_user_list/chat_info_page_left_user_list_item.dart';

class ChatInfoPageLeftUserList extends StatelessWidget {
  const ChatInfoPageLeftUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              "Frühere Midglieder: ${state.leftUsers.length}",
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
            if (state.leftUsers.isEmpty && state.loadingChat) ...[
              const SizedBox(height: 8),
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
            ] else if (state.leftUsers.isNotEmpty) ...{
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChatInfoPageLeftUserListItem(
                    currentUser: state.getCurrentGroupchatUser() ??
                        GroupchatUserEntity(
                          id: BlocProvider.of<AuthCubit>(context)
                              .state
                              .currentUser
                              .id,
                          authId: BlocProvider.of<AuthCubit>(context)
                              .state
                              .currentUser
                              .authId,
                          groupchatUserId: "",
                        ),
                    leftUser: state.leftUsers[index],
                  );
                },
                itemCount: state.leftUsers.length,
              ),
            }
          ],
        );
      },
    );
  }
}
