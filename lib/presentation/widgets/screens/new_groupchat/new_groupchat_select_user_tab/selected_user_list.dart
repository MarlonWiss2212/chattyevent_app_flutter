import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_groupchat_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list/user_grid_list_item.dart';

class SelectedUsersList extends StatelessWidget {
  const SelectedUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
      builder: (context, state) {
        if (state.groupchatUsers == null ||
            state.groupchatUsers != null && state.groupchatUsers!.isEmpty) {
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
                        return SizedBox(
                          width: 70,
                          height: 70,
                          child: UserGridListItem(
                            user: state.groupchatUsers![index].user,
                            onPress: () {
                              final newGroupchatUsers = state.groupchatUsers!
                                  .where(
                                    (element) =>
                                        element.authId !=
                                        state.groupchatUsers![index].authId,
                                  )
                                  .toList();
                              BlocProvider.of<AddGroupchatCubit>(context)
                                  .emitState(
                                groupchatUsers: newGroupchatUsers,
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 8);
                      },
                      itemCount: state.groupchatUsers!.length,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(state.groupchatUsers!.length.toString())
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
