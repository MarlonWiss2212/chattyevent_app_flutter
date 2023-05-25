import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/create_location_private_event_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

class PrivateEventUpdateLocationPage extends StatefulWidget {
  const PrivateEventUpdateLocationPage({super.key});

  @override
  State<PrivateEventUpdateLocationPage> createState() =>
      _PrivateEventUpdateLocationPageState();
}

class _PrivateEventUpdateLocationPageState
    extends State<PrivateEventUpdateLocationPage> {
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController housenumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Location Aktualisieren"),
      ),
      body: BlocListener<CurrentPrivateEventCubit, CurrentPrivateEventState>(
        listener: (context, state) {
          if (state.status == CurrentPrivateEventStateStatus.updated) {
            AutoRouter.of(context).pop();
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: PlatformTextField(
                        hintText: "Stadt",
                        controller: cityController,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: PlatformTextField(
                        hintText: "Postleitzahl",
                        controller: zipController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: PlatformTextFormField(
                              controller: streetController,
                              hintText: "Straße",
                              keyboardType: TextInputType.streetAddress,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          SizedBox(
                            width: 100,
                            child: PlatformTextFormField(
                              controller: housenumberController,
                              hintText: "Nr.",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: Button(
                  text: "Ändern",
                  onTap: () {
                    BlocProvider.of<CurrentPrivateEventCubit>(context)
                        .updateCurrentPrivateEvent(
                      updatePrivateEventDto: UpdatePrivateEventDto(
                        eventLocation: CreatePrivateEventLocationDto(
                          city: cityController.text,
                          zip: zipController.text,
                          housenumber: housenumberController.text,
                          street: streetController.text,
                          country: "DE",
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
