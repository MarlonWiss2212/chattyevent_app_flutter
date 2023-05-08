import 'package:flutter/material.dart';

class RightOnInsightPage extends StatelessWidget {
  const RightOnInsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
