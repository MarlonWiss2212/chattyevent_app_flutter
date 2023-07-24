import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

@RoutePage()
class RightOnDeletionPage extends StatelessWidget {
  const RightOnDeletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Recht auf Löschung",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wenn du auf den Button 'Daten Löschen' klickst werden alle Daten von dir gelöscht",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Folgende Daten können nicht gelöscht werden:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\u2022 User Unique Id",
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Button(
                text: "Daten Löschen",
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (c) {
                      return AcceptDeclineDialog(
                        title: "Wirklich alle Daten Löschen",
                        message: "Willst du wirklich alle deine Daten Löschen",
                        onNoPress: () => Navigator.of(c).pop(),
                        onYesPress: () =>
                            BlocProvider.of<AuthCubit>(context).deleteUser(),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
