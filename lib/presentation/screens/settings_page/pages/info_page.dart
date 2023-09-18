import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
                "settingsPage.infoPage.title",
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
                  leading: const Icon(CupertinoIcons.question),
                  title: Text(
                    "settingsPage.infoPage.faqText",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () async {
                    await settingsUseCases.openFAQPage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: Text(
                    "settingsPage.infoPage.privacyPolicyText",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () async {
                    await settingsUseCases.openDatasecurityPage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.rule),
                  title: Text(
                    "settingsPage.infoPage.termsOfUseText",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () async {
                    await settingsUseCases.openTermsOfUsePage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_page),
                  title: Text(
                    "settingsPage.infoPage.imprintText",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () async {
                    await settingsUseCases.openImprintPage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.text_snippet),
                  title: Text(
                    "settingsPage.infoPage.rightOnDataAccessText",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  trailing: const Icon(Ionicons.chevron_forward),
                  onTap: () async {
                    await settingsUseCases.openRightOnDataAccessPage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text(
                    "settingsPage.infoPage.rightOnDeletionPage.title",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  trailing: const Icon(Ionicons.chevron_forward),
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
