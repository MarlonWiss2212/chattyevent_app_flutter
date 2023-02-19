import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class NewPrivateEventPage extends StatelessWidget {
  const NewPrivateEventPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AddPrivateEventCubit(
        privateEventCubit: BlocProvider.of<PrivateEventCubit>(context),
        privateEventUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
      ),
      child: Builder(
        builder: (context) {
          return BlocListener<AddPrivateEventCubit, AddPrivateEventState>(
            listener: (context, state) async {
              if (state.status == AddPrivateEventStateStatus.success &&
                  state.addedPrivateEvent != null) {
                AutoRouter.of(context).root.replace(
                      PrivateEventWrapperPageRoute(
                        privateEventId: state.addedPrivateEvent!.id,
                        loadPrivateEventFromApiToo: false,
                        privateEventToSet: state.addedPrivateEvent,
                      ),
                    );
              } else if (state.status == AddPrivateEventStateStatus.error &&
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
            child: PlatformScaffold(
              appBar: PlatformAppBar(
                title: const Text('Neues Private Event'),
              ),
              body: AutoTabsRouter.pageView(
                routes: const [
                  NewPrivateEventDetailsTabRoute(),
                  NewPrivateEventSearchGroupchatTabRoute(),
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
                        count: 3,
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
                          child: PlatformElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AddPrivateEventCubit>(context)
                                  .createPrivateEventViaApi();
                            },
                            child: const Text("Speichern"),
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
