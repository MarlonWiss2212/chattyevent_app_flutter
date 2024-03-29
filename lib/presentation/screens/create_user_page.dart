import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/add_current_user_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/create_user_page/create_user_page_birthdate_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/create_user_page/create_user_page_profile_image.dart';

@RoutePage()
class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCurrentUserCubit(
        authCubit: BlocProvider.of<AuthCubit>(context),
        userUseCases: authenticatedLocator(),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("createUserPage.title").tr(),
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logout();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Column(
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
                              TextField(
                                decoration: InputDecoration(
                                  labelText:
                                      "createUserPage.usernameLable".tr(),
                                ),
                                onChanged: (value) {
                                  BlocProvider.of<AddCurrentUserCubit>(context)
                                      .emitState(
                                    username: value,
                                  );
                                },
                                textInputAction: TextInputAction.next,
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
                              const HomeRoute(),
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
                            text: "general.createText".tr(),
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
        );
      }),
    );
  }
}
