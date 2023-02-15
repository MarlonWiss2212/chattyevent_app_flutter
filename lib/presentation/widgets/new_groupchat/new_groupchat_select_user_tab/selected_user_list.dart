import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_groupchat_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_user_from_create_groupchat_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_grid_list_item.dart';

class SelectedUsersList extends StatelessWidget {
  const SelectedUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
      builder: (context, state) {
        if (state.createGroupchatDto.groupchatUsers == null) {
          return Container();
        } else if (state.createGroupchatDto.groupchatUsers!.isEmpty) {
          return Container();
        }
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
                        final createGroupchatUserWithUser = state
                                    .createGroupchatDto.groupchatUsers![index]
                                is CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity
                            ? state.createGroupchatDto.groupchatUsers![index]
                                as CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity
                            : CreateGroupchatUserFromCreateGroupchatDtoWithUserEntity(
                                user: UserEntity(id: ""),
                              );
                        return SizedBox(
                          width: 70,
                          height: 70,
                          child: UserGridListItem(
                            user: createGroupchatUserWithUser.user,
                            onPress: () {
                              List<CreateGroupchatUserFromCreateGroupchatDto>
                                  newGroupchatUsers =
                                  state.createGroupchatDto.groupchatUsers!
                                      .where(
                                        (element) =>
                                            element.userId !=
                                            createGroupchatUserWithUser.userId,
                                      )
                                      .toList();
                              BlocProvider.of<AddGroupchatCubit>(context)
                                  .setCreateGroupchatDto(
                                groupchatUsers: newGroupchatUsers,
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 8);
                      },
                      itemCount:
                          state.createGroupchatDto.groupchatUsers!.length,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(state.createGroupchatDto.groupchatUsers!.length
                      .toString())
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
