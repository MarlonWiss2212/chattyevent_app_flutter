import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/new_private_event/new_private_event_details_tab/select_cover_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/new_private_event/new_private_event_details_tab/select_groupchat_horizontal_list_new_private_event.dart';

class NewPrivateEventDetailsTab extends StatelessWidget {
  const NewPrivateEventDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
        buildWhen: (previous, current) {
          if (previous.coverImage?.path != current.coverImage?.path) {
            return true;
          }
          if (previous.eventDate != current.eventDate) {
            return true;
          }
          if (previous.selectedGroupchat?.id != current.selectedGroupchat?.id) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 8),
              SelectCoverImage(
                imageChanged: (newImage) {
                  BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                    coverImage: newImage,
                  );
                },
                image: state.coverImage,
              ),
              const SizedBox(height: 8),
              PlatformTextFormField(
                controller: TextEditingController(
                  text: state.title,
                ),
                onChanged: (value) =>
                    BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                  title: value,
                ),
                hintText: 'Name*',
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: PlatformElevatedButton(
                  child: Text("Datum wählen: ${state.eventDate}"),
                  onPressed: () async {
                    DateTime currentDate = DateTime.now();
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: state.eventDate ?? currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(currentDate.year + 10),
                    );
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: state.eventDate != null
                            ? state.eventDate!.hour
                            : currentDate.hour,
                        minute: state.eventDate != null
                            ? state.eventDate!.minute
                            : currentDate.minute,
                      ),
                    );

                    if (newDate == null || newTime == null) return;
                    BlocProvider.of<AddPrivateEventCubit>(context).emitState(
                      eventDate: DateTime(
                        newDate.year,
                        newDate.month,
                        newDate.day,
                        newTime.hour,
                        newTime.minute,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Wähle einen Gruppenchat aus: ${state.selectedGroupchat != null ? state.selectedGroupchat!.title : ''}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SelectGroupchatHorizontalListNewPrivateEvent(),
            ],
          );
        },
      ),
    );
  }
}
