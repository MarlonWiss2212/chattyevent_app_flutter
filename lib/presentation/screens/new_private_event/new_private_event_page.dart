import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

class NewPrivateEventPage extends StatelessWidget {
  const NewPrivateEventPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AddPrivateEventCubit(
            homeEventCubit: BlocProvider.of<HomeEventCubit>(context),
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
            privateEventUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
          ),
        ),
        BlocProvider.value(
          value: UserSearchCubit(
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
                          PrivateEventWrapperPageRoute(
                            privateEventId: state.addedPrivateEvent!.id,
                            privateEventStateToSet: CurrentPrivateEventState(
                              currentUserIndex: -1,
                              privateEventUsers: [],
                              privateEventLeftUsers: [],
                              loadingGroupchat: false,
                              loadingPrivateEvent: false,
                              loadingShoppingList: false,
                              shoppingListItemStates: [],
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
                title: const Text('Neues Private Event'),
              ),
              body: AutoTabsRouter.pageView(
                routes: const [
                  NewPrivateEventDetailsTabRoute(),
                  NewPrivateEventTypeTabRoute(),
                  NewPrivateEventSearchTabRoute(),
                  NewPrivateEventDateTabRoute(),
                  NewPrivateEventLocationTabRoute(),
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
                      Expanded(child: child),
                      const SizedBox(height: 8),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: 5,
                        onDotClicked: (index) {
                          pageController.jumpToPage(index);
                        },
                        effect: WormEffect(
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
                              BlocProvider.of<AddPrivateEventCubit>(context)
                                  .createPrivateEventViaApi();
                            },
                            text: "Speichern",
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
