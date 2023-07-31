import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_page/privacy_page_calendar_watch_i_have_time_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget howOthersInteractWithMeColumn(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
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
                    onTap: () => AutoRouter.of(context).push(
                      const GroupchatAddMeRoute(),
                    ),
                    trailing: const Icon(Ionicons.chevron_forward),
                  ),
                  ListTile(
                    title: const Text("Privates Event hinzufügen"),
                    onTap: () => AutoRouter.of(context).push(
                      const PrivateEventAddMeRoute(),
                    ),
                    trailing: const Icon(Ionicons.chevron_forward),
                  ),
                  const PrivacyPageCalendarWatchIHaveTimeSwitch(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
