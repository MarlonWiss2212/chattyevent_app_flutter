import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_groupchat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/button.dart';

class NewGroupchatWrapperPage extends StatelessWidget {
  const NewGroupchatWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AddGroupchatCubit(
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
        chatCubit: BlocProvider.of<ChatCubit>(context),
        groupchatUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
      ),
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<AddGroupchatCubit, AddGroupchatState>(
                listener: (context, state) async {
                  if (state.status == AddGroupchatStateStatus.success &&
                      state.addedChat != null) {
                    AutoRouter.of(context).root.replace(
                          ChatPageWrapperRoute(
                            groupchatId: state.addedChat!.id,
                            chatStateToSet: CurrentChatState(
                              currentUserIndex: -1,
                              currentUserLeftChat: false,
                              loadingPrivateEvents: false,
                              futureConnectedPrivateEvents: [],
                              loadingMessages: false,
                              messages: [],
                              currentChat: state.addedChat!,
                              loadingChat: false,
                              users: [],
                              leftUsers: [],
                            ),
                          ),
                        );
                  }
                },
              ),
            ],
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Neuer Gruppenchat'),
              ),
              body: AutoTabsRouter.pageView(
                routes: const [
                  NewGroupchatDetailsTabRoute(),
                  NewGroupchatSelectUserTabRoute(),
                ],
                builder: (context, child, pageController) {
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
                        count: 2,
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
                              BlocProvider.of<AddGroupchatCubit>(context)
                                  .createGroupchatViaApi();
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
