import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';

@RoutePage()
class NewPrivateEventLocationTab extends StatelessWidget {
  const NewPrivateEventLocationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Standort Wählen (optional)",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: PlatformTextField(
                  hintText: "Stadt",
                  controller: TextEditingController(
                    text: state.city,
                  ),
                  onChanged: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    city: value,
                  ),
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
                  controller: TextEditingController(
                    text: state.zip,
                  ),
                  onChanged: (value) =>
                      BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    zip: value,
                  ),
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
                        controller: TextEditingController(
                          text: state.street,
                        ),
                        onChanged: (value) =>
                            BlocProvider.of<AddPrivateEventCubit>(context)
                                .emitState(
                          street: value,
                        ),
                        hintText: "Straße",
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    SizedBox(
                      width: 100,
                      child: PlatformTextFormField(
                        controller: TextEditingController(
                          text: state.housenumber,
                        ),
                        onChanged: (value) =>
                            BlocProvider.of<AddPrivateEventCubit>(context)
                                .emitState(
                          housenumber: value,
                        ),
                        hintText: "Nr.",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
