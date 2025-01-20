import 'package:flutter/material.dart';

import '../../../product/widgets/drawers/app_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
