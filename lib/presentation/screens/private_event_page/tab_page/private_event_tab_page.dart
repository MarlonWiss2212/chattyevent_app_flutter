import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return AutoTabsRouter.tabBar(
      routes: [
        PrivateEventTabInfoRoute(),
        PrivateEventTabShoppingListRoute(),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          appBar: AppBar(
            leading: const AutoLeadingButton(),
            title:
                BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
              buildWhen: (previous, current) =>
                  previous.privateEvent.title != current.privateEvent.title,
              builder: (context, state) {
                return Hero(
                  tag: "$privateEventId title",
                  child: Text(
                    state.privateEvent.title ?? "Kein Titel",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              },
            ),
            bottom: TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              controller: tabController,
              tabs: const [
                Tab(icon: Icon(Icons.celebration)),
                Tab(icon: Icon(Icons.shopping_cart)),
              ],
            ),
          ),
          body: Column(
            children: [
              BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
                buildWhen: (previous, current) {
                  if (previous.loadingGroupchat != current.loadingGroupchat) {
                    return true;
                  }
                  if (previous.loadingPrivateEvent !=
                      current.loadingPrivateEvent) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state.loadingGroupchat || state.loadingPrivateEvent) {
                    const LinearProgressIndicator();
                  }
                  return const SizedBox();
                },
              ),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
