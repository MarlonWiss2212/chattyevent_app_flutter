import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/private_event_info_tab_details.dart';

class InfoTab extends StatelessWidget {
  final String privateEventId;
  const InfoTab({@PathParam('id') required this.privateEventId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        if (state is CurrentPrivateEventStateWithPrivateEvent) {
          return PrivateEventInfoTabDetails(privateEvent: state.privateEvent);
        }
        return Expanded(
          child: Center(
            child: Text(
              "Fehler beim Laden des Events mit der Id: $privateEventId",
            ),
          ),
        );
      },
    );
  }
}
