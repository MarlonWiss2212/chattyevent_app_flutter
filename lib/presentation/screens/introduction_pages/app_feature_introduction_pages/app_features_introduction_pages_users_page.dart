import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AppFeatureIntroductionPagesUsersPage extends StatelessWidget {
  const AppFeatureIntroductionPagesUsersPage({super.key});

  void navigateToNextPage(BuildContext context) {
    final cubit = BlocProvider.of<IntroductionCubit>(context);
    final introduction = cubit.state.introduction;
    if (introduction == null) return;

    cubit.saveToStorageAndNavigate(
      context,
      introduction: introduction.copyWith(
        appFeatureIntroduction: introduction.appFeatureIntroduction.copyWith(
          finishedUsersPage: true,
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
                "introductionPages.featurePages.usersPage.text",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ).tr(),
            ),
            SizedBox(
              width: double.infinity,
              child: Button(
                onTap: () => navigateToNextPage(context),
                text: "general.continue",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
