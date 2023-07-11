import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/update_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/groupchat/update_groupchat_permissions_dto%20copy.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/groupchat_permissions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupchatUpdatePermissionsPage extends StatelessWidget {
  const GroupchatUpdatePermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mitglieder Berechtigungen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  GroupchatPermissionsMenu(
                    text: "Title ändern",
                    value: state.currentChat.permissions?.changeTitle,
                    changePermission: (GroupchatPermissionEnum value) =>
                        BlocProvider.of<CurrentGroupchatCubit>(context)
                            .updateCurrentGroupchatViaApi(
                      updateGroupchatDto: UpdateGroupchatDto(
                        permissions: UpdateGroupchatPermissionsDto(
                          changeTitle: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GroupchatPermissionsMenu(
                    text: "Beschreibung ändern",
                    value: state.currentChat.permissions?.changeDescription,
                    changePermission: (GroupchatPermissionEnum value) =>
                        BlocProvider.of<CurrentGroupchatCubit>(context)
                            .updateCurrentGroupchatViaApi(
                      updateGroupchatDto: UpdateGroupchatDto(
                        permissions: UpdateGroupchatPermissionsDto(
                          changeDescription: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GroupchatPermissionsMenu(
                    text: "Bild ändern",
                    value: state.currentChat.permissions?.changeProfileImage,
                    changePermission: (GroupchatPermissionEnum value) =>
                        BlocProvider.of<CurrentGroupchatCubit>(context)
                            .updateCurrentGroupchatViaApi(
                      updateGroupchatDto: UpdateGroupchatDto(
                        permissions: UpdateGroupchatPermissionsDto(
                          changeProfileImage: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GroupchatPermissionsMenu(
                    text: "Events erstellen für Chat",
                    value:
                        state.currentChat.permissions?.createEventForGroupchat,
                    changePermission: (GroupchatPermissionEnum value) =>
                        BlocProvider.of<CurrentGroupchatCubit>(context)
                            .updateCurrentGroupchatViaApi(
                      updateGroupchatDto: UpdateGroupchatDto(
                        permissions: UpdateGroupchatPermissionsDto(
                          createEventForGroupchat: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GroupchatPermissionsMenu(
                    text: "User hinzufügen ändern",
                    value: state.currentChat.permissions?.addUsers,
                    changePermission: (GroupchatPermissionEnum value) =>
                        BlocProvider.of<CurrentGroupchatCubit>(context)
                            .updateCurrentGroupchatViaApi(
                      updateGroupchatDto: UpdateGroupchatDto(
                        permissions: UpdateGroupchatPermissionsDto(
                          addUsers: value,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
