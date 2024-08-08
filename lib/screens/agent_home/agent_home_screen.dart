import 'package:flutter/material.dart';

import 'components/body.dart';

class AgentHomeScreen extends StatelessWidget {
  static String routeName = '/agent'; 
  const AgentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Home Screen'),
      ),
      body: const Body(),
    );
  }
}