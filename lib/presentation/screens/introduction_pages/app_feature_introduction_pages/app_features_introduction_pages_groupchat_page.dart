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

    cubit.saveToStorage(
      introduction: introduction.copyWith(
        appFeatureIntroduction: introduction.appFeatureIntroduction.copyWith(
          finishedGroupchatsPage: true,
        ),
      ),
    );
    AutoRouter.of(context).pop();
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
ChattyEvent bietet Ihnen die Möglichkeit, Gruppenchats zu erstellen und mit Ihren Freunden, Familie oder Kollegen zu kommunizieren. Egal ob Sie ein Event planen oder einfach nur in Kontakt bleiben wollen, unsere App ermöglicht es Ihnen, alle Ihre Kontakte an einem Ort zu organisieren.
                
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
