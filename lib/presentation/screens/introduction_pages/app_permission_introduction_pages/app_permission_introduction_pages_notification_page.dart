import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/one_signal_use_cases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/permission_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class AppPermissionIntroductionPagesNotificationPage extends StatelessWidget {
  const AppPermissionIntroductionPagesNotificationPage({super.key});

  void navigateToNextPage(BuildContext context) {
    final cubit = BlocProvider.of<IntroductionCubit>(context);
    final introduction = cubit.state.introduction;
    if (introduction == null) return;

    cubit.saveToStorageAndNavigate(
      context,
      introduction: introduction.copyWith(
        appPermissionIntroduction:
            introduction.appPermissionIntroduction.copyWith(
          finishedNotificationPage: true,
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
            const Icon(
              Ionicons.notifications,
              size: 40,
            ),
            Text(
              "introductionPages.permissionPages.notificationPage.text",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ).tr(),
            const SizedBox(),
            Row(
              children: [
                Flexible(
                  child: Button(
                    onTap: () => navigateToNextPage(context),
                    color: Theme.of(context).colorScheme.surface,
                    text:
                        "introductionPages.permissionPages.general.dontRequestPermissionText"
                            .tr(),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Button(
                    onTap: () async {
                      await serviceLocator<PermissionUseCases>()
                          .requestNotificationPermission();
                      serviceLocator<OneSignalUseCases>()
                          .setNotificationReceivedHandlerIfIHavePermission(
                        appRouter: serviceLocator<AppRouter>(),
                      );
                      // ignore: use_build_context_synchronously
                      navigateToNextPage(context);
                    },
                    text:
                        "introductionPages.permissionPages.general.requestPermissionText"
                            .tr(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
