import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/chat.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/profile.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/search.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media App'),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          Chat(),
          Event(),
          Search(),
          Profile(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) => setState(() => currentIndex = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_outlined),
            selectedIcon: Icon(Icons.event),
            label: 'Event',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Entdecken',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          )
        ],
      ),
    );
  }
}
