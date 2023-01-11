import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/domain/dto/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/modals/getImageModal.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/new_private_event/select_groupchat_horizontal_list_new_private_event.dart';

class NewPrivateEventPage extends StatefulWidget {
  const NewPrivateEventPage({super.key});

  @override
  State<NewPrivateEventPage> createState() => _NewPrivateEventPageState();
}

class _NewPrivateEventPageState extends State<NewPrivateEventPage> {
  DateTime date = DateTime.now();
  final titleFieldController = TextEditingController();
  final groupchatFieldController = TextEditingController();
  File? image;
  GroupchatEntity? selectedGroupchat;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Neues Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Center(
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        onTap: () async {
                          await showGeneralDialog(
                            context: context,
                            pageBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                            ) {
                              return GetImageModal(
                                imageChanged: (newImage) {
                                  setState(() {
                                    image = File(newImage.path);
                                  });
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                        child: image != null
                            ? Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              )
                            : Card(
                                child: SizedBox(
                                  height: 200,
                                  width: size.width,
                                  child: const Icon(Icons.add),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    PlatformTextField(
                      controller: titleFieldController,
                      hintText: 'Name*',
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: PlatformElevatedButton(
                        child: Text("Datum wählen: $date"),
                        onPressed: () async {
                          DateTime currentDate = DateTime.now();
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: currentDate,
                            lastDate: DateTime(currentDate.year + 10),
                          );
                          TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                              hour: date.hour,
                              minute: date.minute,
                            ),
                          );

                          if (newDate == null || newTime == null) return;
                          setState(() {
                            date = DateTime(
                              newDate.year,
                              newDate.month,
                              newDate.day,
                              newTime.hour,
                              newTime.minute,
                            );
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Wähle einen Gruppenchat aus: ${selectedGroupchat != null ? selectedGroupchat!.title : ''}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SelectGroupchatHorizontalListNewPrivateEvent(
                      newGroupchatSelected: (groupchat) {
                        setState(
                          () {
                            selectedGroupchat = groupchat;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            BlocListener<PrivateEventBloc, PrivateEventState>(
              listenWhen: (previous, current) {
                if (current is PrivateEventStateLoaded &&
                    current.createdPrivateEventId != null) {
                  return true;
                }
                return false;
              },
              listener: (context, state) {
                if (state is PrivateEventStateLoaded &&
                    state.createdPrivateEventId != null) {
                  for (final privateEvent in state.privateEvents) {
                    if (privateEvent.id == state.createdPrivateEventId) {
                      AutoRouter.of(context).replace(
                        PrivateEventPageRoute(
                          privateEventId: privateEvent.id,
                          loadPrivateEvent: false,
                        ),
                      );
                    }
                  }
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: PlatformElevatedButton(
                  onPressed: () async {
                    if (selectedGroupchat == null) {
                      return await showPlatformDialog(
                        context: context,
                        builder: (context) {
                          return PlatformAlertDialog(
                            title: const Text("Kein Gruppenchat"),
                            content: const Text(
                              "Ein Event muss einem Chat zugewiesen werden bitte wähle erst einen Chat aus",
                            ),
                            actions: const [OKButton()],
                          );
                        },
                      );
                    }

                    if (image == null) {
                      return await showPlatformDialog(
                        context: context,
                        builder: (context) {
                          return PlatformAlertDialog(
                            title: const Text("Kein Bild"),
                            content: const Text(
                              "Ein Event muss ein Bild haben",
                            ),
                            actions: const [OKButton()],
                          );
                        },
                      );
                    }

                    BlocProvider.of<PrivateEventBloc>(context).add(
                      PrivateEventCreateEvent(
                        createPrivateEventDto: CreatePrivateEventDto(
                          title: titleFieldController.text,
                          eventDate: date,
                          connectedGroupchat: selectedGroupchat!.id,
                          coverImage: image!,
                        ),
                      ),
                    );
                  },
                  child: const Text("Speichern"),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
