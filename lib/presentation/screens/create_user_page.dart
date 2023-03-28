import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/add_current_user_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/create_user_page/create_user_page_birthdate_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/create_user_page/create_user_page_profile_image.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AddCurrentUserCubit(
        authCubit: BlocProvider.of<AuthCubit>(context),
        userUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
      ),
      child: Builder(builder: (context) {
        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: const Text("User Erstellen"),
            trailingActions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logout();
                  AutoRouter.of(context).root.popUntilRoot();
                  AutoRouter.of(context).root.replace(const LoginPageRoute());
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
                              PlatformTextFormField(
                                onChanged: (value) {
                                  BlocProvider.of<AddCurrentUserCubit>(context)
                                      .emitState(
                                    username: value,
                                  );
                                },
                                hintText: 'Benutzername',
                              ),
                              const SizedBox(height: 8),
                              PlatformTextFormField(
                                onChanged: (value) {
                                  BlocProvider.of<AddCurrentUserCubit>(context)
                                      .emitState(
                                    firstname: value,
                                  );
                                },
                                hintText: 'Vorname',
                              ),
                              const SizedBox(height: 8),
                              PlatformTextFormField(
                                onChanged: (value) {
                                  BlocProvider.of<AddCurrentUserCubit>(context)
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
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) async {
                          if (state.status == AuthStateStatus.success) {
                            AutoRouter.of(context)
                                .replace(const HomePageRoute());
                          }
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: PlatformElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AddCurrentUserCubit>(context)
                                  .createCurrentUser();
                            },
                            child: const Text("User Erstellen"),
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
