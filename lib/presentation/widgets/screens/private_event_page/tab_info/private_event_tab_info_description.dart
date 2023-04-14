import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';

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
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: EditInputTextField(
              text: description != null && description.isNotEmpty
                  ? description
                  : "Keine Beschreibung",
              textStyle: Theme.of(context).textTheme.titleMedium,
              editable: state.getCurrentPrivateEventUser()?.organizer == true,
              onSaved: (text) {
                BlocProvider.of<CurrentPrivateEventCubit>(context)
                    .updateCurrentPrivateEvent(
                  updatePrivateEventDto: UpdatePrivateEventDto(
                    description: text,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
