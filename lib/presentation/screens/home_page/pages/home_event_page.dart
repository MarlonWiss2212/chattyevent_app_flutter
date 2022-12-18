import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_horizontal_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/home_page/pages/home_event_page/events_detail_page.dart';
import 'package:social_media_app_flutter/presentation/widgets/home_page/pages/home_event_page/filter_chip_list_private_events.dart';

class HomeEventPage extends StatelessWidget {
  const HomeEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
      ),
      body: BlocBuilder<PrivateEventBloc, PrivateEventState>(
        bloc: BlocProvider.of(context)..add(PrivateEventsRequestEvent()),
        builder: (context, state) {
          if (state is PrivateEventStateLoaded) {
            return EventsDetailPage(privateEvents: state.privateEvents);
          } else if (state is PrivateEventStateLoading) {
            return Center(child: PlatformCircularProgressIndicator());
          } else {
            return Center(
              child: PlatformTextButton(
                child: Text(
                  state is PrivateEventStateError
                      ? state.message
                      : "Daten laden",
                ),
                onPressed: () => BlocProvider.of<PrivateEventBloc>(context).add(
                  PrivateEventsRequestEvent(),
                ),
              ),
            );
          }
        },
      ),
      material: (context, platform) => MaterialScaffoldData(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => AutoRouter.of(context).push(
            const NewPrivateEventPageRoute(),
          ),
          icon: const Icon(Icons.event),
          label: const Text('Neues Event'),
        ),
      ),
    );
  }
}
