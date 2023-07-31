import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_permissions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NewPrivateEventPermissionsTab extends StatelessWidget {
  const NewPrivateEventPermissionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: BlocBuilder<AddEventCubit, AddEventState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 20),
                EventPermissionsMenu(
                  text: "Title ändern",
                  value: state.permissions.changeTitle,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
                    permissions: state.permissions.copyWith(changeTitle: value),
                  ),
                ),
                const SizedBox(height: 8),
                EventPermissionsMenu(
                  text: "Beschreibung ändern",
                  value: state.permissions.changeDescription,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeDescription: value),
                  ),
                ),
                const SizedBox(height: 8),
                EventPermissionsMenu(
                  text: "Bild ändern",
                  value: state.permissions.changeCoverImage,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeCoverImage: value),
                  ),
                ),
                const SizedBox(height: 8),
                EventPermissionsMenu(
                  text: "Datum ändern",
                  value: state.permissions.changeDate,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
                    permissions: state.permissions.copyWith(changeDate: value),
                  ),
                ),
                const SizedBox(height: 8),
                EventPermissionsMenu(
                  text: "Addresse ändern",
                  value: state.permissions.changeAddress,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeAddress: value),
                  ),
                ),
                const SizedBox(height: 8),
                EventPermissionsMenu(
                  text: "Stattfinde Status ändern",
                  value: state.permissions.changeStatus,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(changeStatus: value),
                  ),
                ),
                const SizedBox(height: 8),
                EventPermissionsMenu(
                  text: "User hinzufügen",
                  value: state.permissions.addUsers,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
                    permissions: state.permissions.copyWith(addUsers: value),
                  ),
                ),
                const SizedBox(height: 8),
                EventPermissionsMenu(
                  text: "Einkaufslisten-Item hinzufügen",
                  value: state.permissions.addShoppingListItem,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
                    permissions:
                        state.permissions.copyWith(addShoppingListItem: value),
                  ),
                ),
                const SizedBox(height: 8),
                EventPermissionsMenu(
                  text: "Einkaufslisten-Item bearbeiten",
                  value: state.permissions.updateShoppingListItem,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
                    permissions: state.permissions
                        .copyWith(updateShoppingListItem: value),
                  ),
                ),
                const SizedBox(height: 8),
                EventPermissionsMenu(
                  text: "Einkaufslisten-Item löschen",
                  value: state.permissions.deleteShoppingListItem,
                  changePermission: (value) =>
                      BlocProvider.of<AddEventCubit>(context).emitState(
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
