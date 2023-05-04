import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
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
                "Privatsphäre",
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
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    // AutoRouter.of(context).push(
                    // const ThemeModePageRoute(),
                    // );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.rule),
                  title: Text(
                    "Nutzungsbedingungen",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    //AutoRouter.of(context).push(
                    //const UpdatePasswordPageRoute(),
                    //);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_page),
                  title: Text(
                    "Impressum",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    //AutoRouter.of(context).push(
                    //  const UpdatePasswordPageRoute(),
                    //);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text(
                    "Recht auf Löschung",
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    //BlocProvider.of<AuthCubit>(context).deleteAccount();
                    //AutoRouter.of(context).root.popUntilRoot();
                    //AutoRouter.of(context).root.replace(const LoginPageRoute());
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
