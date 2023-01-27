import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/home_page/mini_profile_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeChatPageRoute(),
        HomeEventPageRoute(),
        LocationRoute(),
        HomeSearchPageRoute(),
        HomeProfilePageRoute(),
      ],
      builder: (context, child, animation) {
        final TabsRouter tabsRouter = AutoTabsRouter.of(context);

        if (Platform.isIOS) {
          return PlatformScaffold(
            body: child,
            bottomNavBar: PlatformNavBar(
              currentIndex: tabsRouter.activeIndex,
              itemChanged: (value) => tabsRouter.setActiveIndex(value),
              backgroundColor: Theme.of(context).colorScheme.background,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  activeIcon: Icon(Icons.chat_bubble),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.celebration_outlined),
                  activeIcon: Icon(Icons.celebration),
                  label: 'Party',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined),
                  activeIcon: Icon(Icons.map),
                  label: 'Map',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search),
                  label: 'Entdecken',
                ),
                BottomNavigationBarItem(
                  icon: MiniProfileImage(),
                  activeIcon: MiniProfileImage(),
                  label: 'Profil',
                )
              ],
            ),
          );
        }

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (value) => tabsRouter.setActiveIndex(value),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble),
                label: 'Chat',
              ),
              NavigationDestination(
                icon: Icon(Icons.celebration_outlined),
                selectedIcon: Icon(Icons.celebration),
                label: 'Party',
              ),
              NavigationDestination(
                icon: Icon(Icons.map_outlined),
                selectedIcon: Icon(Icons.map),
                label: 'Map',
              ),
              NavigationDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search),
                label: 'Entdecken',
              ),
              NavigationDestination(
                icon: MiniProfileImage(),
                selectedIcon: MiniProfileImage(),
                label: 'Profil',
              )
            ],
          ),
        );
      },
    );
  }
}
