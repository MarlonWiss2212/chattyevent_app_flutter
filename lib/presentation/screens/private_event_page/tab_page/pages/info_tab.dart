import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/private_event_info_tab_details.dart';

class InfoTab extends StatelessWidget {
  final String privateEventId;
  const InfoTab({@PathParam('id') required this.privateEventId, super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<CurrentPrivateEventCubit>(context)
          .getPrivateEventAndGroupchatFromApi(
        getOnePrivateEventFilter: GetOnePrivateEventFilter(
          id: privateEventId,
        ),
      ),
      child: BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
        builder: (context, state) {
          if (state is PrivateEventLoading && state.privateEvent.id == "") {
            return Expanded(
              child: Center(child: PlatformCircularProgressIndicator()),
            );
          }

          if (state.privateEvent.id != "") {
            return PrivateEventInfoTabDetails(
              privateEventState: state,
            );
          }

          return Expanded(
            child: Center(
              child: Text(
                "Fehler beim Laden des Events mit der Id: $privateEventId",
              ),
            ),
          );
        },
      ),
    );
  }
}
