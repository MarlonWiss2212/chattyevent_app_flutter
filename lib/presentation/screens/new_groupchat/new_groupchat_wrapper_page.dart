import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_groupchat/add_groupchat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

@RoutePage()
class NewGroupchatWrapperPage extends StatelessWidget {
  const NewGroupchatWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddGroupchatCubit(
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
            chatCubit: BlocProvider.of<ChatCubit>(context),
            groupchatUseCases: authenticatedLocator(),
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
              BlocListener<AddGroupchatCubit, AddGroupchatState>(
                listener: (context, state) async {
                  if (state.status == AddGroupchatStateStatus.success &&
                      state.addedChat != null) {
                    AutoRouter.of(context).root.replace(
                          GroupchatRouteWrapper(
                            groupchatId: state.addedChat!.id,
                            groupchat: state.addedChat!,
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
                    const Text('newGroupchatPage.title').tr(),
                    BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
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
                  NewGroupchatDetailsTab(),
                  NewGroupchatSelectUserTab(),
                  NewGroupchatPermissionsTab(),
                ],
                builder: (context, child, pageController) {
                  BlocProvider.of<AddGroupchatCubit>(context).emitState(
                    subtitle: context.topRoute.title(context),
                  );
                  return Column(
                    children: [
                      BlocBuilder<AddGroupchatCubit, AddGroupchatState>(
                        builder: (context, state) {
                          if (state.status == AddGroupchatStateStatus.loading) {
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
                              BlocProvider.of<AddGroupchatCubit>(context)
                                  .createGroupchatViaApi();
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
