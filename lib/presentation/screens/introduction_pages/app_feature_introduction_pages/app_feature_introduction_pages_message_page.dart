import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class AppFeatureIntroductionPagesMessagePage extends StatelessWidget {
  const AppFeatureIntroductionPagesMessagePage({super.key});

  void navigateToNextPage(BuildContext context) {
    final cubit = BlocProvider.of<IntroductionCubit>(context);
    final introduction = cubit.state.introduction;
    if (introduction == null) return;

    cubit.saveToStorageAndNavigate(
      context,
      introduction: introduction.copyWith(
        appFeatureIntroduction: introduction.appFeatureIntroduction.copyWith(
          finishedMessagesPage: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
              children: [
                Text(
                  "Nachrichten",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Ionicons.checkmark,
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                      size: Theme.of(context).textTheme.bodySmall?.fontSize,
                    ),
                    const SizedBox(width: 8),
                    const Text("Erhalten aber nicht gelesen")
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Stack(
                      children: [
                        Icon(
                          Ionicons.checkmark,
                          color: isDarkMode ? Colors.white54 : Colors.black54,
                          size: Theme.of(context).textTheme.bodySmall?.fontSize,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Icon(
                            Ionicons.checkmark,
                            color: isDarkMode ? Colors.white54 : Colors.black54,
                            size:
                                Theme.of(context).textTheme.bodySmall?.fontSize,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const Text("Erhalten und gelesen")
                  ],
                ),
              ],
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
