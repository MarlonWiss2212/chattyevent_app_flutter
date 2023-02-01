import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app_flutter/application/provider/darkMode.dart';

class ThemeModePage extends StatelessWidget {
  const ThemeModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Theme Mode"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<DarkModeProvider>(
              builder: (context, darkModeProvider, child) {
                return ListTile(
                  title: Text(
                    "Dark-Mode Automatisch: ",
                    style: Theme.of(context).textTheme.titleMedium,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: PlatformSwitch(
                    value: darkModeProvider.autoDarkMode,
                    onChanged: (value) => darkModeProvider.autoDarkMode = value,
                  ),
                );
              },
            ),
            Consumer<DarkModeProvider>(
              builder: (context, darkModeProvider, child) {
                return ListTile(
                  title: Text(
                    "Dark-Mode",
                    style: Theme.of(context).textTheme.titleMedium,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: PlatformSwitch(
                    value: darkModeProvider.darkMode,
                    onChanged: darkModeProvider.autoDarkMode
                        ? null
                        : (value) => darkModeProvider.darkMode = value,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
