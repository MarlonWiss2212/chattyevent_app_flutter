import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_wrapper_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

@RoutePage()
class NewPrivateEventPage extends StatelessWidget {
  const NewPrivateEventPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddPrivateEventCubit(
            homeEventCubit: BlocProvider.of<HomeEventCubit>(context),
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
            calendarUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
            privateEventUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => UserSearchCubit(
            authCubit: BlocProvider.of<AuthCubit>(context),
            userRelationUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
            userUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<AddPrivateEventCubit, AddPrivateEventState>(
                listener: (context, state) async {
                  if (state.status == AddPrivateEventStateStatus.success &&
                      state.addedPrivateEvent != null) {
                    AutoRouter.of(context).root.replace(
                          PrivateEventWrapperPage(
                            privateEventId: state.addedPrivateEvent!.id,
                            privateEventStateToSet:
                                CurrentPrivateEventState.fromPrivateEvent(
                              privateEvent: state.addedPrivateEvent!,
                            ),
                          ),
                        );
                  }
                },
              ),
            ],
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Neues Privates Event'),
              ),
              body: AutoTabsRouter.pageView(
                routes: const [
                  // had a route word after tab before
                  NewPrivateEventDetailsTab(),
                  NewPrivateEventTypeTab(),
                  NewPrivateEventSearchTab(),
                  NewPrivateEventDateTab(),
                  NewPrivateEventLocationTab(),
                  NewPrivateEventPermissionsTab(),
                ],
                builder: (context, child, pageController) {
                  return Column(
                    children: [
                      BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
                        builder: (context, state) {
                          if (state.status ==
                              AddPrivateEventStateStatus.loading) {
                            return const LinearProgressIndicator();
                          }
                          return Container();
                        },
                      ),
                      Expanded(
                        child: HeroControllerScope(
                          controller: HeroController(),
                          child: child,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: 6,
                        onDotClicked: (index) {
                          pageController.jumpToPage(index);
                        },
                        effect: ExpandingDotsEffect(
                          activeDotColor: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Button(
                            onTap: () {
                              BlocProvider.of<AddPrivateEventCubit>(context)
                                  .createPrivateEventViaApi();
                            },
                            text: "Erstellen",
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
