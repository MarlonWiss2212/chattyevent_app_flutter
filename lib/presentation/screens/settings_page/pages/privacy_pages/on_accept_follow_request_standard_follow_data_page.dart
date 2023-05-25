import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/user/update_user_settings/update-on-accept-standard/update_follow_data_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/user/update_user_settings/update_on_accept_standard_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/user/update_user_settings_dto.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';
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
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Neu Anfrage Standard",
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
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                    title: const Text("Darf dich in Gruppenchats adden"),
                    value: state.currentUser.settings?.onAcceptStandard
                            ?.followData?.requesterGroupchatAddPermission ==
                        RequesterGroupchatAddPermissionEnum.add,
                    onChanged: (value) {
                      BlocProvider.of<AuthCubit>(context).updateUser(
                        updateUserDto: UpdateUserDto(
                          settings: UpdateUserSettingsDto(
                            onAcceptStandard: UpdateOnAcceptStandardDto(
                              followData:
                                  UpdateOnAcceptStandardUpdateFollowDataDto(
                                requesterGroupchatAddPermission: value
                                    ? RequesterGroupchatAddPermissionEnum.add
                                    : RequesterGroupchatAddPermissionEnum.none,
                              ),
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
                    value: state.currentUser.settings?.onAcceptStandard
                            ?.followData?.requesterPrivateEventAddPermission ==
                        RequesterPrivateEventAddPermissionEnum.add,
                    onChanged: (value) {
                      BlocProvider.of<AuthCubit>(context).updateUser(
                        updateUserDto: UpdateUserDto(
                          settings: UpdateUserSettingsDto(
                            onAcceptStandard: UpdateOnAcceptStandardDto(
                              followData:
                                  UpdateOnAcceptStandardUpdateFollowDataDto(
                                requesterPrivateEventAddPermission: value
                                    ? RequesterPrivateEventAddPermissionEnum.add
                                    : RequesterPrivateEventAddPermissionEnum
                                        .none,
                              ),
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
