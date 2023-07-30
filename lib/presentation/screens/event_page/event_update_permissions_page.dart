import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/event/event_permission_enum.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_permissions_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_permissions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class EventUpdatePermissionsPage extends StatelessWidget {
  const EventUpdatePermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mitglieder Berechtigungen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: BlocBuilder<CurrentEventCubit, CurrentEventState>(
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  EventPermissionsMenu(
                    text: "Title ändern",
                    value: state.event.permissions?.changeTitle,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
                          changeTitle: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  EventPermissionsMenu(
                    text: "Beschreibung ändern",
                    value: state.event.permissions?.changeDescription,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
                          changeDescription: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  EventPermissionsMenu(
                    text: "Bild ändern",
                    value: state.event.permissions?.changeCoverImage,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
                          changeCoverImage: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  EventPermissionsMenu(
                    text: "Datum ändern",
                    value: state.event.permissions?.changeDate,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
                          changeDate: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  EventPermissionsMenu(
                    text: "Addresse ändern",
                    value: state.event.permissions?.changeAddress,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
                          changeAddress: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  EventPermissionsMenu(
                    text: "Stattfinde Status ändern",
                    value: state.event.permissions?.changeStatus,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
                          changeStatus: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  EventPermissionsMenu(
                    text: "User hinzufügen",
                    value: state.event.permissions?.addUsers,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
                          addUsers: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  EventPermissionsMenu(
                    text: "Einkaufslisten-Item hinzufügen",
                    value: state.event.permissions?.addShoppingListItem,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
                          addShoppingListItem: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  EventPermissionsMenu(
                    text: "Einkaufslisten-Item bearbeiten",
                    value: state.event.permissions?.updateShoppingListItem,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
                          updateShoppingListItem: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  EventPermissionsMenu(
                    text: "Einkaufslisten-Item löschen",
                    value: state.event.permissions?.deleteShoppingListItem,
                    changePermission: (EventPermissionEnum value) =>
                        BlocProvider.of<CurrentEventCubit>(context)
                            .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        permissions: UpdateEventPermissionsDto(
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
