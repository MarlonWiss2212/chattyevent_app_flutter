import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

@RoutePage()
class GroupchatChangeUsernamePage extends StatefulWidget {
  const GroupchatChangeUsernamePage({super.key});

  @override
  State<GroupchatChangeUsernamePage> createState() =>
      _GroupchatChangeUsernamePageState();
}

class _GroupchatChangeUsernamePageState
    extends State<GroupchatChangeUsernamePage> {
  TextEditingController newUsernameController = TextEditingController();

  @override
  void initState() {
    newUsernameController.text = BlocProvider.of<CurrentGroupchatCubit>(context)
            .state
            .getCurrentGroupchatUser()
            ?.usernameForChat ??
        "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("groupchatPage.changeChatUsernamePage.title").tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText:
                          "groupchatPage.changeChatUsernamePage.newChatUsername"
                              .tr(),
                    ),
                    controller: newUsernameController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Button(
                onTap: () => BlocProvider.of<CurrentGroupchatCubit>(context)
                    .updateGroupchatUserViaApi(
                      userId: BlocProvider.of<AuthCubit>(context)
                          .state
                          .currentUser
                          .id,
                      updateGroupchatUserDto: UpdateGroupchatUserDto(
                        removeUsernameForChat: true,
                      ),
                    )
                    .then(
                      (value) => AutoRouter.of(context).pop(),
                    ),
                text: "groupchatPage.changeChatUsernamePage.deleteChatName",
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Button(
                onTap: () => BlocProvider.of<CurrentGroupchatCubit>(context)
                    .updateGroupchatUserViaApi(
                      userId: BlocProvider.of<AuthCubit>(context)
                          .state
                          .currentUser
                          .id,
                      updateGroupchatUserDto: UpdateGroupchatUserDto(
                        usernameForChat: newUsernameController.text,
                      ),
                    )
                    .then(
                      (value) => AutoRouter.of(context).pop(),
                    ),
                text: "general.saveText",
              ),
            )
          ],
        ),
      ),
    );
  }
}
