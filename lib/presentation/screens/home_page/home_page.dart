import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
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
  @override
  void initState() {
    super.initState();
    BlocProvider.of<IntroductionCubit>(context)
        .getFromStorageOrCreateIfNullAndNavigate(context);
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        const HomeChatRoute(),
        const HomeEventRoute(),
        const HomeMapRoute(),
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
                      destinations: [
                        NavigationRailDestination(
                          icon: const Icon(Ionicons.chatbubble_outline),
                          selectedIcon: const Icon(Ionicons.chatbubble),
                          label:
                              const Text('homePage.pages.chatPage.title').tr(),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(Icons.celebration_outlined),
                          selectedIcon: const Icon(Icons.celebration),
                          label:
                              const Text('homePage.pages.eventPage.title').tr(),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(Ionicons.map_outline),
                          selectedIcon: const Icon(Ionicons.map),
                          label:
                              const Text('homePage.pages.mapPage.title').tr(),
                        ),
                        NavigationRailDestination(
                          icon: const Icon(Ionicons.search_outline),
                          selectedIcon: const Icon(Ionicons.search),
                          label: const Text('homePage.pages.searchPage.title')
                              .tr(),
                        ),
                        NavigationRailDestination(
                          icon: const MiniProfileImage(),
                          selectedIcon: const MiniProfileImage(),
                          label: const Text('homePage.pages.profilePage.title')
                              .tr(),
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
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(Ionicons.chatbubble_outline),
                      activeIcon: const Icon(Ionicons.chatbubble),
                      label: 'homePage.pages.chatPage.title'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.celebration_outlined),
                      activeIcon: const Icon(Icons.celebration),
                      label: 'homePage.pages.eventPage.title'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Ionicons.map_outline),
                      activeIcon: const Icon(Ionicons.map),
                      label: 'homePage.pages.mapPage.title'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Ionicons.search_outline),
                      activeIcon: const Icon(Ionicons.search),
                      label: 'homePage.pages.searchPage.title'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: const MiniProfileImage(),
                      activeIcon: const MiniProfileImage(),
                      label: "homePage.pages.profilePage.title".tr(),
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
