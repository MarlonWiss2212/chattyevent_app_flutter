import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AppFeatureIntroductionPagesPrivateEventPage extends StatelessWidget {
  const AppFeatureIntroductionPagesPrivateEventPage({super.key});

  void navigateToNextPage(BuildContext context) {
    final cubit = BlocProvider.of<IntroductionCubit>(context);
    final introduction = cubit.state.introduction;
    if (introduction == null) return;

    cubit.saveToStorageAndNavigate(
      context,
      introduction: introduction.copyWith(
        appFeatureIntroduction: introduction.appFeatureIntroduction.copyWith(
          finishedPrivateEventPage: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            SingleChildScrollView(
              child: Text(
                """
Die spezielle Party-Planungsfunktion von ChattyEvent ermöglicht es Ihnen, Events rasch und mühelos auf die Beine zu stellen und sämtliche Details spielend zu teilen. Hierbei können Sie die Veranstaltung mit einem Gruppenchat verknüpfen oder auch unabhängig davon planen. Diese innovative Funktion gewährleistet, dass wirklich jeder eingeladen wird und dass sämtliche relevanten Einzelheiten auf einen Blick ersichtlich sind.

Um die Event-Planung noch weiter zu vereinfachen, haben wir sogar eine praktische Einkaufslistenfunktion integriert. Auf diese Weise können Sie klipp und klar festlegen, welche Beiträge jeder Event-Teilnehmer beisteuern sollte. So verhindern Sie, dass irgendetwas vergessen wird, und können sämtliche Einzelheiten im Vorfeld perfekt koordinieren.
                """,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Button(
                onTap: () => navigateToNextPage(context),
                text: "Weiter",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
