import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
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
                "Privatsphäre & Sicherheit",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
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
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 14,
                  bottom: 20,
                  right: 20,
                ),
                child: Text(
                  "Wie dürfen andere mit dir interagieren?",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Divider(thickness: 3),
              ListTile(
                title: const Text("Gruppenchat hinzufügen"),
                //   subtitle: const Text(
                //   "Follower dich in ein Gruppenchat hinzufügen, ohne diese Berechtigung aber wenigstens Einladen",
                //                      style: Theme.of(context).textTheme.bodySmall,
                // ),
                onTap: () => AutoRouter.of(context).push(
                  const GroupchatAddMeRoute(),
                ),
                trailing: const Icon(Ionicons.chevron_forward),
              ),
              ListTile(
                title: const Text("Privates Event hinzufügen"),
                //   subtitle: const Text(
                //     "Follower dich in ein Privates Event hinzufügen, ohne diese Berechtigung aber wenigstens Einladen",
                //                      style: Theme.of(context).textTheme.bodySmall,
                //   ),
                onTap: () => AutoRouter.of(context).push(
                  const PrivateEventAddMeRoute(),
                ),
                trailing: const Icon(Ionicons.chevron_forward),
              ),
              ListTile(
                title: const Text("Kalendar sehen"),
                subtitle: Text(
                  "Follower können sehen ob du an einen Termin Zeit hast",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
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
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 14,
                  bottom: 20,
                  right: 20,
                ),
                child: Text(
                  "Persönliche Daten",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Divider(thickness: 3),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(
                  "Email ändern",
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Ionicons.chevron_forward),
                onTap: () {
                  //      AutoRouter.of(context).push(const UpdateEmailRoute());
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.lock_fill),
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
            ],
          ),
        ),
      ),
    );
  }
}
