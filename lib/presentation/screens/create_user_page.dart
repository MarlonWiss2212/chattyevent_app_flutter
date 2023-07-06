import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/add_current_user_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/create_user_page/create_user_page_birthdate_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/create_user_page/create_user_page_profile_image.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCurrentUserCubit(
        authCubit: BlocProvider.of<AuthCubit>(context),
        userUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("User Erstellen"),
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logout();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: BlocListener<NotificationCubit, NotificationState>(
            listener: (context, state) async {
              if (state is NotificationAlert) {
                return await showDialog(
                  context: context,
                  builder: (c) {
                    return CustomAlertDialog(
                      notificationAlert: state,
                      context: c,
                    );
                  },
                );
              }
            },
            child: Column(
              children: [
                BlocBuilder<AddCurrentUserCubit, AddCurrentUserState>(
                  builder: (context, state) {
                    if (state.status == AddCurrentUserStateStatus.loading) {
                      return const LinearProgressIndicator();
                    }
                    return const SizedBox();
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                const CreateUserPageProfileImage(),
                                const SizedBox(height: 20),
                                PlatformTextFormField(
                                  onChanged: (value) {
                                    BlocProvider.of<AddCurrentUserCubit>(
                                            context)
                                        .emitState(
                                      username: value,
                                    );
                                  },
                                  hintText: 'Benutzername',
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 8),
                                PlatformTextFormField(
                                  onChanged: (value) {
                                    BlocProvider.of<AddCurrentUserCubit>(
                                            context)
                                        .emitState(
                                      firstname: value,
                                    );
                                  },
                                  textInputAction: TextInputAction.next,
                                  hintText: 'Vorname',
                                ),
                                const SizedBox(height: 8),
                                PlatformTextFormField(
                                  onChanged: (value) {
                                    BlocProvider.of<AddCurrentUserCubit>(
                                            context)
                                        .emitState(
                                      lastname: value,
                                    );
                                  },
                                  hintText: 'Nachname',
                                ),
                                const SizedBox(height: 8),
                                const CreateUserPageBirthdayButton()
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        BlocListener<AddCurrentUserCubit, AddCurrentUserState>(
                          listener: (context, state) async {
                            if (state.status ==
                                AddCurrentUserStateStatus.created) {
                              AutoRouter.of(context).replace(
                                const AuthorizedPageRoute(children: [
                                  BlocInitPageRoute(children: [HomePageRoute()])
                                ]),
                              );
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Button(
                              onTap: () {
                                BlocProvider.of<AddCurrentUserCubit>(context)
                                    .createCurrentUser();
                              },
                              text: "User Erstellen",
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
