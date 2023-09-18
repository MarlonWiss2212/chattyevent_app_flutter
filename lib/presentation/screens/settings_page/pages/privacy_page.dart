import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class SettingsPrivacyPage extends StatefulWidget {
  const SettingsPrivacyPage({super.key});

  @override
  State<SettingsPrivacyPage> createState() => _SettingsPrivacyPageState();
}

class _SettingsPrivacyPageState extends State<SettingsPrivacyPage> {
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
                "settingsPage.privacyPage.title",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ).tr(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                howOthersInteractWithMeColumn(context),
                personalDataColumn(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget howOthersInteractWithMeColumn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "settingsPage.privacyPage.howOthersInteractWithYouText",
                  style: Theme.of(context).textTheme.titleLarge,
                ).tr(),
              ),
              const Divider(thickness: 3),
              ListTile(
                title: const Text(
                  "settingsPage.privacyPage.groupchatAddMePage.title",
                ).tr(),
                onTap: () => AutoRouter.of(context).push(
                  const GroupchatAddMeRoute(),
                ),
                trailing: const Icon(Ionicons.chevron_forward),
              ),
              ListTile(
                title: const Text(
                  "settingsPage.privacyPage.privateEventAddMePage.title",
                ).tr(),
                onTap: () => AutoRouter.of(context).push(
                  const PrivateEventAddMeRoute(),
                ),
                trailing: const Icon(Ionicons.chevron_forward),
              ),
              ListTile(
                title: const Text(
                  "settingsPage.privacyPage.calendarWatchIHaveTimePage.title",
                ).tr(),
                subtitle: Text(
                  "settingsPage.privacyPage.calenderTileMessage",
                  style: Theme.of(context).textTheme.bodySmall,
                ).tr(),
                onTap: () => AutoRouter.of(context).push(
                  const CalendarWatchIHaveTimeRoute(),
                ),
                trailing: const Icon(Ionicons.chevron_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget personalDataColumn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "settingsPage.privacyPage.personalDataTitle",
                  style: Theme.of(context).textTheme.titleLarge,
                ).tr(),
              ),
              const Divider(thickness: 3),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(
                  "settingsPage.privacyPage.updateBirthdatePage.title",
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ).tr(),
                trailing: const Icon(Ionicons.chevron_forward),
                onTap: () {
                  AutoRouter.of(context).push(const UpdateBirthdateRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(
                  "settingsPage.privacyPage.updateEmailPage.title",
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ).tr(),
                trailing: const Icon(Ionicons.chevron_forward),
                onTap: () {
                  AutoRouter.of(context).push(const UpdateEmailRoute());
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.lock_fill),
                title: Text(
                  "settingsPage.privacyPage.updatePasswordPage.title",
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ).tr(),
                trailing: const Icon(Ionicons.chevron_forward),
                onTap: () {
                  AutoRouter.of(context).push(const UpdatePasswordRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
