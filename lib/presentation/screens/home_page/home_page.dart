import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/home_page/mini_profile_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        const HomeChatPageRoute(),
        const HomeEventPageRoute(),
        const HomeMapPageRoute(),
        const HomeSearchPageRoute(),
        HomeProfilePageRoute(
          userId: BlocProvider.of<AuthCubit>(context).state.currentUser.id,
        )
      ],
      builder: (context, child, animation) {
        final TabsRouter tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: BlocListener<NotificationCubit, NotificationState>(
            listener: (context, state) async {
              if (state is NotificationAlert) {
                return await showDialog(
                  context: context,
                  builder: (c) {
                    return CustomAlertDialog(
                      notificationAlert: state,
                      context: c,
                    );
                  },
                );
              }
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    children: [
                      NavigationRail(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        selectedIndex: tabsRouter.activeIndex,
                        selectedIconTheme: IconThemeData(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        onDestinationSelected: (value) =>
                            tabsRouter.setActiveIndex(value),
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.chat_bubble_outline),
                            selectedIcon: Icon(Icons.chat_bubble),
                            label: Text('Chat'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.celebration_outlined),
                            selectedIcon: Icon(Icons.celebration),
                            label: Text('Party'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.map_outlined),
                            selectedIcon: Icon(Icons.map),
                            label: Text('Map'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.search_outlined),
                            selectedIcon: Icon(Icons.search),
                            label: Text('Entdecken'),
                          ),
                          NavigationRailDestination(
                            icon: MiniProfileImage(),
                            selectedIcon: MiniProfileImage(),
                            label: Text('Profil'),
                          )
                        ],
                      ),
                      Expanded(child: child),
                    ],
                  );
                } else {
                  return child;
                }
              },
            ),
          ),
          bottomNavigationBar: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth <= 600) {
                return BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  onTap: (value) => tabsRouter.setActiveIndex(value),
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  selectedItemColor: Theme.of(context).colorScheme.onBackground,
                  unselectedItemColor:
                      Theme.of(context).colorScheme.onBackground,
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
