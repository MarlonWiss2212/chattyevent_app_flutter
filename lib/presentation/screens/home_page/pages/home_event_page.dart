import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/home_page/pages/home_event_page/private_event_grid_lists.dart';

class HomeEventPage extends StatelessWidget {
  const HomeEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<PrivateEventCubit>(context).state
        is! PrivateEventLoaded) {
      BlocProvider.of<PrivateEventCubit>(context).getPrivateEventsViaApi();
    }

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
            if (state is PrivateEventError) {
              return await showPlatformDialog(
                context: context,
                builder: (context) {
                  return PlatformAlertDialog(
                    title: Text(state.title),
                    content: Text(state.message),
                    actions: const [OKButton()],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            const emptyReturn = Center(child: Text("Keine Privaten Events"));

            if (state.privateEvents.isEmpty && state is! PrivateEventLoading) {
              return emptyReturn;
            }

            if (state.privateEvents.isEmpty && state is PrivateEventLoading) {
              return SkeletonListView(
                itemBuilder: (p0, p1) {
                  return SkeletonListTile(
                    hasSubtitle: true,
                    titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                    subtitleStyle: const SkeletonLineStyle(
                        width: double.infinity, height: 16),
                    leadingStyle: const SkeletonAvatarStyle(
                      shape: BoxShape.circle,
                    ),
                  );
                },
              );
            }

            return PrivateEventGridLists(privateEvents: state.privateEvents);
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
