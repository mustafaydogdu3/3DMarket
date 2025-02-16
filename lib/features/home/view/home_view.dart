import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../product/widgets/drawers/app_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesome.house_solid,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_view_outlined,
            ),
            label: 'Categories',
          ),
        ],
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
