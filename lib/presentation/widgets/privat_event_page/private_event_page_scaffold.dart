import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/current_private_event_groupchat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventPageScaffold extends StatelessWidget {
  final String privateEventId;
  const PrivateEventPageScaffold({
    super.key,
    required this.privateEventId,
  });

  @override
  Widget build(BuildContext context) {
    bool dataLoaded = false;

    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        if (state is CurrentPrivateEventStateWithPrivateEvent &&
            state.privateEvent.connectedGroupchat != null &&
            dataLoaded == false) {
          BlocProvider.of<CurrentPrivateEventGroupchatCubit>(context)
              .setCurrentGroupchatViaApi(
            groupchatId: state.privateEvent.connectedGroupchat!,
          );
          BlocProvider.of<UserCubit>(context).getUsersViaApi();
          dataLoaded = true;
        }

        return AutoTabsRouter.tabBar(
          routes: [
            InfoTabRoute(),
            ShoppingListTabRoute(),
          ],
          builder: (context, child, tabController) {
            return PlatformScaffold(
              appBar: PlatformAppBar(
                leading: const AutoLeadingButton(),
                title: Hero(
                  tag: "$privateEventId title",
                  child: Text(
                    state is CurrentPrivateEventStateWithPrivateEvent &&
                            state.privateEvent.title != null
                        ? state.privateEvent.title!
                        : "Kein Titel",
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
              body: state is CurrentPrivateEventLoading
                  ? Center(child: PlatformCircularProgressIndicator())
                  : state is CurrentPrivateEventStateWithPrivateEvent
                      ? Column(
                          children: [
                            if (state is CurrentPrivateEventEditing) ...{
                              const LinearProgressIndicator()
                            },
                            Expanded(child: child),
                          ],
                        )
                      : Center(
                          child: Text(
                            "Fehler beim Laden des Events mit der Id $privateEventId",
                            textAlign: TextAlign.center,
                          ),
                        ),
            );
          },
        );
      },
    );
  }
}
