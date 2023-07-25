import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AppFeatureIntroductionPagesUsersPage extends StatelessWidget {
  const AppFeatureIntroductionPagesUsersPage({super.key});

  void navigateToNextPage(BuildContext context) {
    final cubit = BlocProvider.of<IntroductionCubit>(context);
    final introduction = cubit.state.introduction;
    if (introduction == null) return;

    cubit.saveToStorage(
      introduction: introduction.copyWith(
        appFeatureIntroduction: introduction.appFeatureIntroduction.copyWith(
          finishedUsersPage: true,
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
                "ChattyEvent verfügt auch über ein Freundschaftssystem, das es Ihnen ermöglicht, die Berechtigungen Ihrer Freunde zu verwalten. Sie können bestimmte Freunde zu einer Gruppe hinzufügen und deren Zugriff auf die Gruppe steuern. Sie können auch individuelle Berechtigungen für jeden Freund festlegen, um sicherzustellen, dass Ihre Gruppe organisiert und sicher bleibt.",
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
