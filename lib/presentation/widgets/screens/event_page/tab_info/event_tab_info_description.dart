import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';

class EventTabInfoDescription extends StatelessWidget {
  const EventTabInfoDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        if (state.event.description == null && state.loadingEvent) {
          return const SkeletonLine();
        }

        final String? description = state.event.description;
        final Widget widget = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: EditInputTextField(
            textOverflow: TextOverflow.visible,
            text: description != null && description.isNotEmpty
                ? description
                : "Keine Beschreibung",
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            textStyle: Theme.of(context).textTheme.titleMedium,
            editable: state.getCurrentEventUser()?.role ==
                EventUserRoleEnum.organizer,
            onSaved: (text) {
              BlocProvider.of<CurrentEventCubit>(context).updateCurrentEvent(
                updateEventDto: UpdateEventDto(
                  description: text,
                ),
              );
            },
          ),
        );
        if (description == null || description.isEmpty) {
          return Center(child: widget);
        }
        return widget;
      },
    );
  }
}
