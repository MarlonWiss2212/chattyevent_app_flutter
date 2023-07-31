import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
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
                "Einstellungen",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: Text(
                    "Darstellung",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () {
                    AutoRouter.of(context).push(const ThemeModeRoute());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: Text(
                    "Privatsphäre & Sicherheit",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () {
                    AutoRouter.of(context).push(const SettingsPrivacyRoute());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.password),
                  title: Text(
                    "Password ändern",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () {
                    AutoRouter.of(context).push(const UpdatePasswordRoute());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    "Info & Datenschutz",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                    "Abmelden",
                    style: TextStyle(color: Colors.red),
                  ),
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
