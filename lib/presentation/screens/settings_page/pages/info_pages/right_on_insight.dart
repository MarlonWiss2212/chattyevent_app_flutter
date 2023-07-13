import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RightOnInsightPage extends StatelessWidget {
  const RightOnInsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Recht auf Einsicht",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "In aktiver Entwicklung solltest du trotzdem dein Recht auf einsicht beanpruchen wollen nach DSGVO dann schreibe uns eine E-Mail",
        ),
      ),
    );
  }
}
