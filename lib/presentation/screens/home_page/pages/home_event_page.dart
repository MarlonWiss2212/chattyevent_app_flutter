import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_horizontal_list_skeleton.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/home_page/pages/home_event_page/home_event_page_details.dart';

@RoutePage()
class HomeEventPage extends StatefulWidget {
  const HomeEventPage({super.key});

  @override
  State<HomeEventPage> createState() => _HomeEventPageState();
}

class _HomeEventPageState extends State<HomeEventPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeEventCubit>(context).getfutureEventsViaApi();
    BlocProvider.of<HomeEventCubit>(context).getPastEventsViaApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Text(
                "homePage.pages.eventPage.title",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ).tr(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => AutoRouter.of(context).push(
                  const NewPrivateEventRoute(),
                ),
              ),
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.wait([
                BlocProvider.of<HomeEventCubit>(context)
                    .getfutureEventsViaApi(reload: true),
                BlocProvider.of<HomeEventCubit>(context)
                    .getPastEventsViaApi(reload: true),
              ]);
            },
          ),
          BlocBuilder<HomeEventCubit, HomeEventState>(
            builder: (context, state) {
              if (state.futureEvents.isEmpty &&
                  state.pastEvents.isEmpty &&
                  state.loadingFutureEvents == false &&
                  state.loadingPastEvents == false) {
                return SliverFillRemaining(
                  child: Center(
                    child: const Text(
                      "homePage.pages.eventPage.noEventsText",
                    ).tr(),
                  ),
                );
              }

              if (state.futureEvents.isEmpty &&
                  state.pastEvents.isEmpty &&
                  (state.loadingFutureEvents == true ||
                      state.loadingPastEvents == true)) {
                return const EventHorizontalListSkeleton();
              }

              return const HomeEventPageDetails();
            },
          ),
        ],
      ),
    );
  }
}
