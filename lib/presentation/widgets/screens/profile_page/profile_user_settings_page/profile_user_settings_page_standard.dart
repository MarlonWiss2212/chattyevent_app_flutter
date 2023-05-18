import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_groupchat_add_permission_enum.dart';
import 'package:chattyevent_app_flutter/core/enums/user_relation/requester_private_event_add_permission_enum.dart';
import 'package:flutter/material.dart';

class ProfileUserSettingsPageStandard extends StatelessWidget {
  final Widget title;
  final RequesterGroupchatAddPermissionEnum? requesterGroupchatAddPermission;
  final void Function(RequesterGroupchatAddPermissionEnum)?
      requesterGroupchatAddPermissionOnChanged;
  final RequesterPrivateEventAddPermissionEnum?
      requesterPrivateEventAddPermission;
  final void Function(RequesterPrivateEventAddPermissionEnum)?
      requesterPrivateEventAddPermissionOnChanged;
  //TODO calender

  const ProfileUserSettingsPageStandard({
    super.key,
    required this.title,
    this.requesterGroupchatAddPermissionOnChanged,
    this.requesterGroupchatAddPermission,
    this.requesterPrivateEventAddPermission,
    this.requesterPrivateEventAddPermissionOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const AutoLeadingButton(),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(title: title),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SwitchListTile.adaptive(
                title: const Text("Darf dich in Gruppenchats adden"),
                value: requesterGroupchatAddPermission ==
                    RequesterGroupchatAddPermissionEnum.add,
                onChanged: requesterGroupchatAddPermissionOnChanged != null
                    ? (value) {
                        requesterGroupchatAddPermissionOnChanged!(
                          value
                              ? RequesterGroupchatAddPermissionEnum.add
                              : RequesterGroupchatAddPermissionEnum.none,
                        );
                      }
                    : null,
              ),
              SwitchListTile.adaptive(
                title: const Text("Darf dich in Events adden"),
                value: requesterPrivateEventAddPermission ==
                    RequesterPrivateEventAddPermissionEnum.add,
                onChanged: requesterPrivateEventAddPermissionOnChanged != null
                    ? (value) {
                        requesterPrivateEventAddPermissionOnChanged!(
                          value
                              ? RequesterPrivateEventAddPermissionEnum.add
                              : RequesterPrivateEventAddPermissionEnum.none,
                        );
                      }
                    : null,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
