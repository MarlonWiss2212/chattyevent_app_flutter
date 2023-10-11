import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chattyevent_app_flutter/application/provider/dark_mode.dart';

@RoutePage()
class ThemeModePage extends StatelessWidget {
  const ThemeModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("settingsPage.themeModePage.title").tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<DarkModeProvider>(
              builder: (context, darkModeProvider, child) {
                return SwitchListTile.adaptive(
                  title: Text(
                    "settingsPage.themeModePage.darkModeAutomaticText",
                    style: Theme.of(context).textTheme.titleMedium,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  value: darkModeProvider.autoDarkMode,
                  onChanged: (value) => darkModeProvider.autoDarkMode = value,
                );
              },
            ),
            Consumer<DarkModeProvider>(
              builder: (context, darkModeProvider, child) {
                return SwitchListTile.adaptive(
                  title: Text(
                    "settingsPage.themeModePage.darkModeText",
                    style: Theme.of(context).textTheme.titleMedium,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                  value: darkModeProvider.darkMode,
                  onChanged: darkModeProvider.autoDarkMode
                      ? null
                      : (value) => darkModeProvider.darkMode = value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
