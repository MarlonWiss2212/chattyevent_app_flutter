import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';

@RoutePage()
class NewPrivateEventLocationTab extends StatelessWidget {
  const NewPrivateEventLocationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AddEventCubit, AddEventState>(
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 4,
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Stadt",
                    ),
                    controller: TextEditingController(
                      text: state.city,
                    ),
                    onChanged: (value) =>
                        BlocProvider.of<AddEventCubit>(context).emitState(
                      city: value,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Postleitzahl",
                    ),
                    controller: TextEditingController(text: state.zip),
                    onChanged: (value) =>
                        BlocProvider.of<AddEventCubit>(context).emitState(
                      zip: value,
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: "Straße",
                          ),
                          controller: TextEditingController(
                            text: state.street,
                          ),
                          onChanged: (value) =>
                              BlocProvider.of<AddEventCubit>(context).emitState(
                            street: value,
                          ),
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: "Nr.",
                          ),
                          controller: TextEditingController(
                            text: state.housenumber,
                          ),
                          onChanged: (value) =>
                              BlocProvider.of<AddEventCubit>(context).emitState(
                            housenumber: value,
                          ),
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
                          BlocProvider.of<AddEventCubit>(context).emitState(
                            countryCode: code.code,
                          );
                        }
                      },
                      initialSelection: 'DE',
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
            );
          },
        ),
      ),
    );
  }
}
