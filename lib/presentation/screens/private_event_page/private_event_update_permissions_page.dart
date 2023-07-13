import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_permission_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_permissions_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/private_event_permissions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class PrivateEventUpdatePermissionsPage extends StatelessWidget {
  const PrivateEventUpdatePermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mitglieder Berechtigungen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child:
              BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  PrivateEventPermissionsMenu(
                    text: "Title ändern",
                    value: state.privateEvent.permissions?.changeTitle,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          changeTitle: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrivateEventPermissionsMenu(
                    text: "Beschreibung ändern",
                    value: state.privateEvent.permissions?.changeDescription,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          changeDescription: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrivateEventPermissionsMenu(
                    text: "Bild ändern",
                    value: state.privateEvent.permissions?.changeCoverImage,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          changeCoverImage: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrivateEventPermissionsMenu(
                    text: "Datum ändern",
                    value: state.privateEvent.permissions?.changeDate,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          changeDate: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrivateEventPermissionsMenu(
                    text: "Addresse ändern",
                    value: state.privateEvent.permissions?.changeAddress,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          changeAddress: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrivateEventPermissionsMenu(
                    text: "Stattfinde Status ändern",
                    value: state.privateEvent.permissions?.changeStatus,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          changeStatus: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrivateEventPermissionsMenu(
                    text: "User hinzufügen",
                    value: state.privateEvent.permissions?.addUsers,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          addUsers: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrivateEventPermissionsMenu(
                    text: "Einkaufslisten-Item hinzufügen",
                    value: state.privateEvent.permissions?.addShoppingListItem,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          addShoppingListItem: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrivateEventPermissionsMenu(
                    text: "Einkaufslisten-Item bearbeiten",
                    value:
                        state.privateEvent.permissions?.updateShoppingListItem,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          updateShoppingListItem: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrivateEventPermissionsMenu(
                    text: "Einkaufslisten-Item löschen",
                    value:
                        state.privateEvent.permissions?.deleteShoppingListItem,
                    changePermission: (PrivateEventPermissionEnum value) =>
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        permissions: UpdatePrivateEventPermissionsDto(
                          deleteShoppingListItem: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
