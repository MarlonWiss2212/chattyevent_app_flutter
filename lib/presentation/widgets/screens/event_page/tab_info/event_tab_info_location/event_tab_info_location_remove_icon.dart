import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class EventTabInfoLocationRemoveIcon extends StatelessWidget {
  const EventTabInfoLocationRemoveIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (c) {
            return AcceptDeclineDialog(
              title:
                  "eventPage.tabs.infoTab.addressButton.removeAddressDialog.title"
                      .tr(),
              message:
                  "eventPage.tabs.infoTab.addressButton.removeAddressDialog.message"
                      .tr(),
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
