import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/event_list/event_horizontal_list_item_skeleton.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/home_page/pages/home_event_page/home_event_page_details.dart';

class HomeEventPage extends StatelessWidget {
  const HomeEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PrivateEventCubit>(context).getPrivateEventsViaApi();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Social Media App'),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh:
            BlocProvider.of<PrivateEventCubit>(context).getPrivateEventsViaApi,
        child: BlocConsumer<PrivateEventCubit, PrivateEventState>(
          listener: (context, state) async {
            if (state.status == PrivateEventStateStatus.error &&
                state.error != null) {
              return await showPlatformDialog(
                context: context,
                builder: (context) {
                  return PlatformAlertDialog(
                    title: Text(state.error!.title),
                    content: Text(state.error!.message),
                    actions: const [OKButton()],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state.privateEvents.isEmpty &&
                state.status != PrivateEventStateStatus.loading) {
              return const Center(child: Text("Keine Privaten Events"));
            }

            if (state.privateEvents.isEmpty &&
                state.status == PrivateEventStateStatus.loading) {
              return const EventHorizontalListItemSekeleton();
            }

            return HomeEventPageDetails(privateEvents: state.privateEvents);
          },
        ),
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
