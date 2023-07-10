import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;

  const CustomTabBar({
    required this.tabs,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Material(
        color: Colors.transparent,
        child: TabBar(
          isScrollable: false,
          splashBorderRadius: BorderRadius.circular(8),
          controller: controller,
          tabs: tabs,
        ),
      ),
    );
  }
}
