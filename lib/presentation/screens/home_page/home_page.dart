import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/home_page/mini_profile_image.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SettingsUseCases settingsUseCases = serviceLocator();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<IntroductionCubit>(context)
        .getFromStorageOrCreateIfNullAndNavigate(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await settingsUseCases.showAdMobPopUpIfRequired();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        const HomeChatRoute(),
        const HomeEventRoute(),
        const HomeSearchRoute(),
        HomeProfileRoute(
          userId: BlocProvider.of<AuthCubit>(context).state.currentUser.id,
        )
      ],
      builder: (context, child) {
        final TabsRouter tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Row(
                  children: [
                    NavigationRail(
                      selectedIndex: tabsRouter.activeIndex,
                      labelType: NavigationRailLabelType.selected,
                      selectedIconTheme: IconThemeData(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      onDestinationSelected: (value) =>
                          tabsRouter.setActiveIndex(value),
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Ionicons.chatbubble_outline),
                          selectedIcon: Icon(Ionicons.chatbubble),
                          label: Text('Chats'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.celebration_outlined),
                          selectedIcon: Icon(Icons.celebration),
                          label: Text('Events'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Ionicons.search_outline),
                          selectedIcon: Icon(Ionicons.search),
                          label: Text('Entdecken'),
                        ),
                        NavigationRailDestination(
                          icon: MiniProfileImage(),
                          selectedIcon: MiniProfileImage(),
                          label: Text('Profil'),
                        )
                      ],
                    ),
                    Expanded(
                      child: HeroControllerScope(
                        controller: HeroController(),
                        child: child,
                      ),
                    ),
                  ],
                );
              } else {
                return HeroControllerScope(
                  controller: HeroController(),
                  child: child,
                );
              }
            },
          ),
          bottomNavigationBar: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth <= 600) {
                return BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) => tabsRouter.setActiveIndex(value),
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  elevation: 0,
                  selectedItemColor: Theme.of(context).colorScheme.onBackground,
                  unselectedItemColor:
                      Theme.of(context).colorScheme.onBackground,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Ionicons.chatbubble_outline),
                      activeIcon: Icon(Ionicons.chatbubble),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.celebration_outlined),
                      activeIcon: Icon(Icons.celebration),
                      label: 'Party',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Ionicons.search_outline),
                      activeIcon: Icon(Ionicons.search),
                      label: 'Entdecken',
                    ),
                    BottomNavigationBarItem(
                      icon: MiniProfileImage(),
                      activeIcon: MiniProfileImage(),
                      label: 'Profil',
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
