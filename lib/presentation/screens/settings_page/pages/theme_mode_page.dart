import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chattyevent_app_flutter/application/provider/darkMode.dart';

@RoutePage()
class ThemeModePage extends StatelessWidget {
  const ThemeModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Theme Mode"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<DarkModeProvider>(
              builder: (context, darkModeProvider, child) {
                return SwitchListTile.adaptive(
                  title: Text(
                    "Dark-Mode Automatisch: ",
                    style: Theme.of(context).textTheme.titleMedium,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: darkModeProvider.autoDarkMode,
                  onChanged: (value) => darkModeProvider.autoDarkMode = value,
                );
              },
            ),
            Consumer<DarkModeProvider>(
              builder: (context, darkModeProvider, child) {
                return SwitchListTile.adaptive(
                  title: Text(
                    "Dark-Mode",
                    style: Theme.of(context).textTheme.titleMedium,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
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
