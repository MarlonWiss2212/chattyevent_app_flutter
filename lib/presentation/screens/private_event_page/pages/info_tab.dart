import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/private_event_info_page.dart';

class InfoTab extends StatelessWidget {
  final String privateEventId;
  const InfoTab({@PathParam('id') required this.privateEventId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivateEventBloc, PrivateEventState>(
      builder: (context, state) {
        PrivateEventEntity? foundPrivateEvent;
        if (state is PrivateEventStateLoaded) {
          for (final privateEvent in state.privateEvents) {
            if (privateEvent.id == privateEventId) {
              foundPrivateEvent = privateEvent;
            }
          }
        }

        if (foundPrivateEvent == null) {
          return const Expanded(
            child: Center(child: Text("Privates Event nicht gefunden")),
          );
        }

        return PrivateEventInfoPage(privateEvent: foundPrivateEvent);
      },
    );
  }
}
