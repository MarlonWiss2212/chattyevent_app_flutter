import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget howOthersInteractWithMeColumn(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Wie dürfen andere mit dir interagieren?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Divider(thickness: 3),
                ListTile(
                  title: const Text("Gruppenchat hinzufügen"),
                  onTap: () {
                    print("test");
                  },
                  trailing: const Icon(Ionicons.arrow_forward),
                ),
                ListTile(
                  title: const Text("Privates Event hinzufügen"),
                  onTap: () {
                    print("test");
                  },
                  trailing: const Icon(Ionicons.arrow_forward),
                ),
                SwitchListTile.adaptive(
                  title: const Text(
                      "Kalender sehen ob du an einen Termin Zeit hast (für follower)"),
                  value: true,
                  onChanged: (newValue) {},
                )
              ],
            ),
          ),
        ),
      );
}
