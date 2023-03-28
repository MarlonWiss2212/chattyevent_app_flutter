import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Einstellungen"),
        leading: const AutoLeadingButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Theme Mode",
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                AutoRouter.of(context).push(
                  const ThemeModePageRoute(),
                );
              },
            ),
            ListTile(
              title: Text(
                "Update Password",
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                AutoRouter.of(context).push(
                  const UpdatePasswordPageRoute(),
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
                AutoRouter.of(context).root.popUntilRoot();
                AutoRouter.of(context).root.replace(const LoginPageRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
