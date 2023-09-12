import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/utils/localization_utils.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/geocoding/create_address_dto.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/create_event_location_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

@RoutePage()
class EventUpdateLocationPage extends StatefulWidget {
  const EventUpdateLocationPage({super.key});

  @override
  State<EventUpdateLocationPage> createState() =>
      _EventUpdateLocationPageState();
}

class _EventUpdateLocationPageState extends State<EventUpdateLocationPage> {
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController housenumberController = TextEditingController();
  String countryCode = LocalizationUtils.systemLocale.split("_")[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Location Aktualisieren"),
      ),
      body: BlocListener<CurrentEventCubit, CurrentEventState>(
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
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: "Stadt",
                        ),
                        controller: cityController,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: "Postleitzahl",
                        ),
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
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Straße',
                              ),
                              controller: streetController,
                              keyboardType: TextInputType.streetAddress,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Nr.',
                              ),
                              controller: housenumberController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CountryCodePicker(
                          onChanged: (code) {
                            if (code.code != null) {
                              setState(() => countryCode = code.code!);
                            }
                          },
                          initialSelection: countryCode,
                          barrierColor: Colors.transparent.withOpacity(.6),
                          dialogBackgroundColor:
                              Theme.of(context).colorScheme.surface,
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: true,
                          alignLeft: false,
                        ),
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
                    BlocProvider.of<CurrentEventCubit>(context)
                        .updateCurrentEvent(
                      updateEventDto: UpdateEventDto(
                        eventLocation: CreateEventLocationDto(
                          address: CreateAddressDto(
                            city: cityController.text,
                            zip: zipController.text,
                            housenumber: housenumberController.text,
                            street: streetController.text,
                            country: countryCode,
                          ),
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
