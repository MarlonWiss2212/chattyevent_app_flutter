import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/image_with_label_button.dart';

class SelectGroupchatHorizontalListNewPrivateEvent extends StatelessWidget {
  final Function(GroupchatEntity groupchat) newGroupchatSelected;
  const SelectGroupchatHorizontalListNewPrivateEvent({
    super.key,
    required this.newGroupchatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state.chats.isEmpty && state is ChatLoading) {
            return Center(
              child: PlatformCircularProgressIndicator(),
            );
          }

          if (state.chats.isEmpty && state is! ChatLoading) {
            return const Center(child: Text("Keine Chats"));
          }

          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 100,
                height: 100,
                child: ImageWithLabelButton(
                  label: state.chats[index].title ?? "Kein Titel",
                  imageLink: state.chats[index].profileImageLink,
                  onTap: () => newGroupchatSelected(state.chats[index]),
                ),
              );
            },
            itemCount: state.chats.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          );
        },
      ),
    );
  }
}
