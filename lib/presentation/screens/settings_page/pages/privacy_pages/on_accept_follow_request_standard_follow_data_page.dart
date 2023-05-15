import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/user/update_on_accept_follow_request_standard_follow_data_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/user/update_user_settings_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnAcceptFollowRequestStandardFollowDataPage extends StatelessWidget {
  const OnAcceptFollowRequestStandardFollowDataPage({super.key});

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
                "Neu Anfrage Standardeinstellungen",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Wenn du eine neu Freundschaftsanfrage animmst bekommt dieser User standardmäßig diese Berechtigungen:",
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                    title: const Text("Darf dich in Gruppenchats adden"),
                    value: state
                            .currentUser
                            .settings
                            ?.onAcceptFollowRequestStandardFollowData
                            ?.standardRequesterGroupchatAddPermission ==
                        "ADD",
                    onChanged: (value) {
                      BlocProvider.of<AuthCubit>(context).updateUser(
                        updateUserDto: UpdateUserDto(
                          settings: UpdateUserSettingsDto(
                            onAcceptFollowRequestStandardFollowData:
                                UpdateOnAcceptFollowRequestStandardFollowDataDto(
                              standardRequesterGroupchatAddPermission:
                                  value ? "ADD" : "NONE",
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                    title: const Text("Darf dich in Events adden"),
                    value: state
                            .currentUser
                            .settings
                            ?.onAcceptFollowRequestStandardFollowData
                            ?.standardRequesterPrivateEventAddPermission ==
                        "ADD",
                    onChanged: (value) {
                      BlocProvider.of<AuthCubit>(context).updateUser(
                        updateUserDto: UpdateUserDto(
                          settings: UpdateUserSettingsDto(
                            onAcceptFollowRequestStandardFollowData:
                                UpdateOnAcceptFollowRequestStandardFollowDataDto(
                              standardRequesterPrivateEventAddPermission:
                                  value ? "ADD" : "NONE",
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
