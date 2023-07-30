import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class PrivateEventTabInfoLocationRemoveIcon extends StatelessWidget {
  const PrivateEventTabInfoLocationRemoveIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (c) {
            return AcceptDeclineDialog(
              title: "Addresse entfernen",
              message: "Möchtest du die Addresse wirklich entfernen?",
              onNoPress: () => Navigator.of(c).pop(),
              onYesPress: () => BlocProvider.of<CurrentEventCubit>(context)
                  .updateCurrentEvent(
                    updateEventDto: UpdateEventDto(
                      removeEventLocation: true,
                    ),
                  )
                  .then(
                    (value) => Navigator.of(c).pop(),
                  ),
            );
          },
        );
      },
      icon: const Icon(Ionicons.close),
    );
  }
}
