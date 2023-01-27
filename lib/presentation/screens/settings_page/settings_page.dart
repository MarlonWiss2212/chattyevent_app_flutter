import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/provider/darkMode.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: const Text("Einstellungen")),
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
                if (darkModeProvider.autoDarkMode) {
                  return Container();
                }

                return ListTile(
                  title: Text(
                    "Dark-Mode",
                    style: Theme.of(context).textTheme.titleMedium,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: PlatformSwitch(
                    value: darkModeProvider.darkMode,
                    onChanged: (value) => darkModeProvider.darkMode = value,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Abmelden",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                BlocProvider.of<AuthCubit>(context).logout();
                AutoRouter.of(context).popUntilRoot();
                AutoRouter.of(context).replace(const LoginPageRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
