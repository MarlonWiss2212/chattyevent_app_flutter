import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/private_event/create_location_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';

class NewPrivateEventLocationPage extends StatefulWidget {
  final DateTime date;
  final String title;
  final File image;
  final GroupchatEntity selectedGroupchat;
  const NewPrivateEventLocationPage({
    super.key,
    required this.date,
    required this.image,
    required this.selectedGroupchat,
    required this.title,
  });

  @override
  State<NewPrivateEventLocationPage> createState() =>
      _NewPrivateEventLocationPageState();
}

class _NewPrivateEventLocationPageState
    extends State<NewPrivateEventLocationPage> {
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController housenumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Neues Event Location (Optional)'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
                    builder: (context, state) {
                  if (state is AddPrivateEventLoading) {
                    return const LinearProgressIndicator();
                  }
                  return Container();
                }),
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
                const SizedBox(height: 8),
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: PlatformElevatedButton(
                onPressed: () async {
                  BlocProvider.of<AddPrivateEventCubit>(context)
                      .createPrivateEvent(
                    createPrivateEventDto: CreatePrivateEventDto(
                      title: widget.title,
                      eventDate: widget.date,
                      connectedGroupchat: widget.selectedGroupchat.id,
                      coverImage: widget.image,
                      eventLocation: cityController.text != "" ||
                              housenumberController.text != "" ||
                              streetController.text != "" ||
                              zipController.text != ""
                          ? CreatePrivateEventLocationDto(
                              city: cityController.text,
                              country: "DE",
                              housenumber: housenumberController.text,
                              street: streetController.text,
                              zip: zipController.text,
                            )
                          : null,
                    ),
                  );
                },
                child: const Text("Speichern"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
