import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';

@RoutePage()
class NewPrivateEventLocationTab extends StatelessWidget {
  const NewPrivateEventLocationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<AddEventCubit, AddEventState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
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
            ],
          );
        },
      ),
    );
  }
}
