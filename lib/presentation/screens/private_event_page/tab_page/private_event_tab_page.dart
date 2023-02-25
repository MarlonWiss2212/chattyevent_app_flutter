import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventTabPage extends StatelessWidget {
  final String privateEventId;
  const PrivateEventTabPage({
    super.key,
    @PathParam('id') required this.privateEventId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return AutoTabsRouter.tabBar(
          routes: [
            InfoTabRoute(),
            const ShoppingListWrapperPageRoute(),
          ],
          builder: (context, child, tabController) {
            return PlatformScaffold(
              appBar: PlatformAppBar(
                leading: const AutoLeadingButton(),
                title: Hero(
                  tag: "$privateEventId title",
                  child: Text(
                    state.privateEvent.title ?? "Kein Titel",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                material: (context, platform) => MaterialAppBarData(
                  bottom: TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(text: "Info", icon: Icon(Icons.celebration)),
                      Tab(
                        text: "Einkaufsliste",
                        icon: Icon(Icons.shopping_cart),
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                children: [
                  if (state.loadingGroupchat || state.loadingPrivateEvent) ...{
                    const LinearProgressIndicator()
                  },
                  Expanded(child: child),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
