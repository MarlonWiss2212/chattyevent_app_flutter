import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_groupchat/add_groupchat_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/groupchat/groupchat_permission_enum.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/groupchat_permissions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NewGroupchatPermissionsTab extends StatelessWidget {
  const NewGroupchatPermissionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 20),
                GroupchatPermissionsMenu(
                  text: "Title ändern",
                  value: state.permissions.changeTitle,
                  changePermission: (GroupchatPermissionEnum value) =>
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    permissions: state.permissions.copyWith(changeTitle: value),
                  ),
                ),
                const SizedBox(height: 8),
                GroupchatPermissionsMenu(
                  text: "Beschreibung ändern",
                  value: state.permissions.changeDescription,
                  changePermission: (GroupchatPermissionEnum value) =>
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeDescription: value),
                  ),
                ),
                const SizedBox(height: 8),
                GroupchatPermissionsMenu(
                  text: "Bild ändern",
                  value: state.permissions.changeProfileImage,
                  changePermission: (GroupchatPermissionEnum value) =>
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeProfileImage: value),
                  ),
                ),
                const SizedBox(height: 8),
                GroupchatPermissionsMenu(
                  text: "Events erstellen für Chat",
                  value: state.permissions.createEventForGroupchat,
                  changePermission: (GroupchatPermissionEnum value) =>
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    permissions: state.permissions
                        .copyWith(createEventForGroupchat: value),
                  ),
                ),
                const SizedBox(height: 8),
                GroupchatPermissionsMenu(
                  text: "User hinzufügen",
                  value: state.permissions.addUsers,
                  changePermission: (GroupchatPermissionEnum value) =>
                      BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    permissions: state.permissions.copyWith(addUsers: value),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
