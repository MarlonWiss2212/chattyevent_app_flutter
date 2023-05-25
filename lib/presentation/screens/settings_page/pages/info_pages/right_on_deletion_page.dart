import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/accept_decline_dialog.dart';

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
      body: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Wenn du auf den Button 'Daten Löschen' klickst werden alle Daten nach DSGVO von dir gelöscht dies sind folgende:",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    """
User Daten, 
Chat User Daten, 
Private Event User Daten, 
Freundschafts Daten, 
Selbst erstellte Events,
Selbst erstellte Nachrichten,
Selbst erstellte Einkaufslisten Items,
Selbst erstellte Eingekauften Mengen für Items,
""",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
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
    );
  }
}
