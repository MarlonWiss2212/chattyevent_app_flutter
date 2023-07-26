import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user/private_event_user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';

class PrivateEventTabInfoDescription extends StatelessWidget {
  const PrivateEventTabInfoDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        if (state.privateEvent.description == null &&
            state.loadingPrivateEvent) {
          return const SkeletonLine();
        }

        final String? description = state.privateEvent.description;
        final Widget widget = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: EditInputTextField(
            text: description != null && description.isNotEmpty
                ? description
                : "Keine Beschreibung",
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            textStyle: Theme.of(context).textTheme.titleMedium,
            editable: state.getCurrentPrivateEventUser()?.role ==
                PrivateEventUserRoleEnum.organizer,
            onSaved: (text) {
              BlocProvider.of<CurrentPrivateEventCubit>(context)
                  .updateCurrentPrivateEvent(
                updatePrivateEventDto: UpdatePrivateEventDto(
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
