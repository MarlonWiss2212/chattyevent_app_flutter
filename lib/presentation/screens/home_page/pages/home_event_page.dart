import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/event_horizontal_list_skeleton.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/home_page/pages/home_event_page/home_event_page_details.dart';

class HomeEventPage extends StatefulWidget {
  const HomeEventPage({super.key});

  @override
  State<HomeEventPage> createState() => _HomeEventPageState();
}

class _HomeEventPageState extends State<HomeEventPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeEventCubit>(context).getFuturePrivateEventsViaApi();
    BlocProvider.of<HomeEventCubit>(context).getPastPrivateEventsViaApi();
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
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Events",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => AutoRouter.of(context).push(
                  const NewPrivateEventPageRoute(),
                ),
              ),
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.wait([
                BlocProvider.of<HomeEventCubit>(context)
                    .getFuturePrivateEventsViaApi(reload: true),
                BlocProvider.of<HomeEventCubit>(context)
                    .getPastPrivateEventsViaApi(reload: true),
              ]);
            },
          ),
          BlocBuilder<HomeEventCubit, HomeEventState>(
            builder: (context, state) {
              if (state.privateEvents.isEmpty &&
                  state.status != HomeEventStateStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(child: Text("Keine Privaten Events")),
                );
              }

              if (state.privateEvents.isEmpty &&
                  state.status == HomeEventStateStatus.loading) {
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
