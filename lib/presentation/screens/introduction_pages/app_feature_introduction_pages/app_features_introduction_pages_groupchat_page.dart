import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AppFeatureIntroductionPagesGroupchatPage extends StatelessWidget {
  const AppFeatureIntroductionPagesGroupchatPage({super.key});

  void navigateToNextPage(BuildContext context) {
    final cubit = BlocProvider.of<IntroductionCubit>(context);
    final introduction = cubit.state.introduction;
    if (introduction == null) return;

    cubit.saveToStorageAndNavigate(
      context,
      introduction: introduction.copyWith(
        appFeatureIntroduction: introduction.appFeatureIntroduction.copyWith(
          finishedGroupchatsPage: true,
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
ChattyEvent ist die ultimative Lösung für Ihre Party- und Eventplanung! Unsere innovative App dreht sich rund um Gruppeninteraktion und erleichtert Ihnen die Kommunikation mit Ihren Freunden, Familie oder Kollegen. Egal, ob Sie eine epische Party organisieren oder einfach nur engeren Kontakt pflegen möchten – ChattyEvent ist der ideale Begleiter, um all Ihre Kontakte an einem zentralen Ort zu bündeln.

ChattyEvent zeichnet sich durch seine mühelose Benutzerfreundlichkeit aus und hält sämtliche Tools bereit, die Sie für eine geschmeidige Gruppenkommunikation und eine tadellose Event-Planung benötigen. Warten Sie nicht länger – probieren Sie es noch heute aus und überzeugen Sie sich selbst von der Leichtigkeit und Effizienz unserer App. Steigern Sie das Potenzial Ihrer Partyplanung und Eventorganisation mit ChattyEvent!                       

Viel Spaß mit ChattyEvent!
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
