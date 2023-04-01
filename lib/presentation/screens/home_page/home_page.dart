import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/home_page/mini_profile_image.dart';

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

        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onTap: (value) => tabsRouter.setActiveIndex(value),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: Theme.of(context).colorScheme.onBackground,
            unselectedItemColor: Theme.of(context).colorScheme.onBackground,
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
      },
    );
  }
}
