import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class SettingsInfoPage extends StatefulWidget {
  const SettingsInfoPage({super.key});

  @override
  State<SettingsInfoPage> createState() => _SettingsInfoPageState();
}

class _SettingsInfoPageState extends State<SettingsInfoPage> {
  final SettingsUseCases settingsUseCases = serviceLocator();
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
                "Info & Datenschutz",
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
                  leading: const Icon(Icons.security),
                  title: Text(
                    "Datenschutzerklärung",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Ionicons.arrow_forward),
                  onTap: () async {
                    await settingsUseCases.openDatasecurityPage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.rule),
                  title: Text(
                    "Nutzungsbedingungen",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Ionicons.arrow_forward),
                  onTap: () async {
                    await settingsUseCases.openTermsOfUsePage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_page),
                  title: Text(
                    "Impressum",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Ionicons.arrow_forward),
                  onTap: () {
                    AutoRouter.of(context).push(
                      const ImprintRoute(),
                    );
                  },
                ),
                /*ListTile(
                  leading: const Icon(Icons.text_snippet),
                  title: Text(
                    "Recht auf Einsicht",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Ionicons.arrow_forward),
                  onTap: () {
                    AutoRouter.of(context).push(
                      const RightOnInsightPageRoute(),
                    );
                  },
                ),*/
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text(
                    "Recht auf Löschung",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Ionicons.arrow_forward),
                  onTap: () {
                    AutoRouter.of(context).push(
                      const RightOnDeletionRoute(),
                    );
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
