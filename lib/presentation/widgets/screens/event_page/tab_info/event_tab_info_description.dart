import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';

class EventTabInfoDescription extends StatelessWidget {
  const EventTabInfoDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: BlocBuilder<CurrentEventCubit, CurrentEventState>(
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
                  : "general.noDescriptionText".tr(),
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
      ),
    );
  }
}
