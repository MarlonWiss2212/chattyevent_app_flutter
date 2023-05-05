import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

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
            flexibleSpace: FlexibleSpaceBar(
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
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    AutoRouter.of(context).push(
                      const ThemeModePageRoute(),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: Text(
                    "Privatsphäre",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    AutoRouter.of(context).push(
                      const PrivacyPageRoute(),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.password),
                  title: Text(
                    "Password ändern",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    AutoRouter.of(context).push(
                      const UpdatePasswordPageRoute(),
                    );
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
