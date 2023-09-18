import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
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
          "settingsPage.infoPage.rightOnDeletionPage.title",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ).tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "settingsPage.infoPage.rightOnDeletionPage.text",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ).tr(),
                    const SizedBox(height: 20),
                    const Text(
                      "settingsPage.infoPage.rightOnDeletionPage.followingDataWillBeDeletedText",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ).tr(),
                    const Text(
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
                text: "settingsPage.infoPage.rightOnDeletionPage.deleteData",
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (c) {
                      return AcceptDeclineDialog(
                        title:
                            "settingsPage.infoPage.rightOnDeletionPage.dialog.title",
                        message:
                            "settingsPage.infoPage.rightOnDeletionPage.dialog.message",
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
