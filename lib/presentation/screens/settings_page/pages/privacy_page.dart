import 'package:flutter/material.dart';

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
                /*
                ListTile(
                  leading: const Icon(Icons.person_add),
                  title: Text(
                    "Neue Anfrage Standard",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () async {
                    AutoRouter.of(context).push(
                      const OnAcceptFollowRequestStandardFollowDataPageRoute(),
                    );
                  },
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
