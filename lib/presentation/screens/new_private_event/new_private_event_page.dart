import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_event/add_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
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
          create: (context) => AddEventCubit(
            homeEventCubit: BlocProvider.of<HomeEventCubit>(context),
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
            calendarUseCases: authenticatedLocator(),
            eventUseCases: authenticatedLocator(),
          ),
        ),
        BlocProvider(
          create: (context) => UserSearchCubit(
            authCubit: BlocProvider.of<AuthCubit>(context),
            userRelationUseCases: authenticatedLocator(),
            userUseCases: authenticatedLocator(),
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<AddEventCubit, AddEventState>(
                listener: (context, state) async {
                  if (state.status == AddEventStateStatus.success &&
                      state.addedEvent != null) {
                    AutoRouter.of(context).root.replace(
                          EventWrapperRoute(
                            eventId: state.addedEvent!.id,
                            eventStateToSet: CurrentEventState.fromEvent(
                              event: state.addedEvent!,
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
                title: Column(
                  children: [
                    const Text('newPrivateEventPage.title').tr(),
                    BlocBuilder<AddEventCubit, AddEventState>(
                      buildWhen: (p, c) => p.subtitle != c.subtitle,
                      builder: (context, state) {
                        return Text(
                          state.subtitle,
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: AutoTabsRouter.pageView(
                routes: const [
                  NewPrivateEventDetailsTab(),
                  NewPrivateEventTypeTab(),
                  NewPrivateEventSearchTab(),
                  NewPrivateEventDateTab(),
                  NewPrivateEventLocationTab(),
                  NewPrivateEventPermissionsTab(),
                ],
                builder: (context, child, pageController) {
                  BlocProvider.of<AddEventCubit>(context).emitState(
                    subtitle: context.topRoute.title(context),
                  );
                  return Column(
                    children: [
                      BlocBuilder<AddEventCubit, AddEventState>(
                        builder: (context, state) {
                          if (state.status == AddEventStateStatus.loading) {
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
                          activeDotColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Button(
                            onTap: () {
                              BlocProvider.of<AddEventCubit>(context)
                                  .createEventViaApi();
                            },
                            text: "general.createText".tr(),
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
