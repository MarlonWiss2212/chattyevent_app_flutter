import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeChatPageRoute(),
        HomeEventPageRoute(),
        HomeSearchPageRoute(),
        HomeProfilePageRoute(),
      ],
      builder: (context, child, animation) {
        final TabsRouter tabsRouter = AutoTabsRouter.of(context);

        return PlatformScaffold(
          body: child,
          bottomNavBar: PlatformNavBar(
            currentIndex: tabsRouter.activeIndex,
            itemChanged: (value) => tabsRouter.setActiveIndex(value),
            backgroundColor: Theme.of(context).colorScheme.background,
            material: (_, __) => MaterialNavBarData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).colorScheme.onBackground,
              unselectedItemColor: Theme.of(context).colorScheme.onBackground,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            cupertino: (context, platform) => CupertinoTabBarData(),
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
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Entdecken',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profil',
              )
            ],
          ),
        );
      },
    );
  }
}
