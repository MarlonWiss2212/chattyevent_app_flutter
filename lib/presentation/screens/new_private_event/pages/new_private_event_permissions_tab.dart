import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/private_event_permissions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPrivateEventPermissionsTab extends StatelessWidget {
  const NewPrivateEventPermissionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Mitglieder Berechtigungen",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                PrivateEventPermissionsMenu(
                  text: "Title ändern",
                  value: state.permissions.changeTitle,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions: state.permissions.copyWith(changeTitle: value),
                  ),
                ),
                const SizedBox(height: 8),
                PrivateEventPermissionsMenu(
                  text: "Beschreibung ändern",
                  value: state.permissions.changeDescription,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeDescription: value),
                  ),
                ),
                const SizedBox(height: 8),
                PrivateEventPermissionsMenu(
                  text: "Bild ändern",
                  value: state.permissions.changeCoverImage,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeCoverImage: value),
                  ),
                ),
                const SizedBox(height: 8),
                PrivateEventPermissionsMenu(
                  text: "Datum ändern",
                  value: state.permissions.changeDate,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions: state.permissions.copyWith(changeDate: value),
                  ),
                ),
                const SizedBox(height: 8),
                PrivateEventPermissionsMenu(
                  text: "Addresse ändern",
                  value: state.permissions.changeAddress,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeAddress: value),
                  ),
                ),
                const SizedBox(height: 8),
                PrivateEventPermissionsMenu(
                  text: "Stattfinde Status ändern",
                  value: state.permissions.changeStatus,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeStatus: value),
                  ),
                ),
                const SizedBox(height: 8),
                PrivateEventPermissionsMenu(
                  text: "User hinzufügen",
                  value: state.permissions.addUsers,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions: state.permissions.copyWith(addUsers: value),
                  ),
                ),
                const SizedBox(height: 8),
                PrivateEventPermissionsMenu(
                  text: "Einkaufslisten-Item hinzufügen",
                  value: state.permissions.addShoppingListItem,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(addShoppingListItem: value),
                  ),
                ),
                const SizedBox(height: 8),
                PrivateEventPermissionsMenu(
                  text: "Einkaufslisten-Item bearbeiten",
                  value: state.permissions.updateShoppingListItem,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions: state.permissions
                        .copyWith(updateShoppingListItem: value),
                  ),
                ),
                const SizedBox(height: 8),
                PrivateEventPermissionsMenu(
                  text: "Einkaufslisten-Item löschen",
                  value: state.permissions.deleteShoppingListItem,
                  changePermission: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    permissions: state.permissions
                        .copyWith(deleteShoppingListItem: value),
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
