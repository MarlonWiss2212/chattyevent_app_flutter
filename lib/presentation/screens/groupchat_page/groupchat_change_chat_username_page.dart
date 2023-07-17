import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

//TODO: optimize this page and add deleting groupchat username name
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
        title: const Text("Chat username ändern"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  PlatformTextFormField(
                    controller: newUsernameController,
                    hintText: 'Neuer chat username',
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
                      /// TODO optimize this later
                      (value) => AutoRouter.of(context).pop(),
                    ),
                text: "Chat Namen Löschen",
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
                      /// TODO optimize this later
                      (value) => AutoRouter.of(context).pop(),
                    ),
                text: "Speichern",
              ),
            )
          ],
        ),
      ),
    );
  }
}