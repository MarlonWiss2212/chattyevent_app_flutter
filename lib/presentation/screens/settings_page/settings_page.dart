import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                "settingsPage.title",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ).tr(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: Text(
                    "settingsPage.themeModePage.title",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () {
                    AutoRouter.of(context).push(const ThemeModeRoute());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: Text(
                    "settingsPage.privacyPage.title",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () {
                    AutoRouter.of(context).push(const SettingsPrivacyRoute());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    "settingsPage.infoPage.title",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () {
                    AutoRouter.of(context).push(const SettingsInfoRoute());
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const Text(
                    "settingsPage.logout",
                    style: TextStyle(color: Colors.red),
                  ).tr(),
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
