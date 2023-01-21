import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/home_page/pages/home_event_page/private_event_grid_lists.dart';

class HomeEventPage extends StatelessWidget {
  const HomeEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PrivateEventCubit>(context).getPrivateEventsViaApi();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
      ),
      body: BlocBuilder<PrivateEventCubit, PrivateEventState>(
        builder: (context, state) {
          if (state is PrivateEventStateLoaded) {
            return PrivateEventGridLists(privateEvents: state.privateEvents);
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
                onPressed: () => BlocProvider.of<PrivateEventCubit>(context)
                    .getPrivateEventsViaApi(),
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
          label: Text(
            'Neues Event',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
