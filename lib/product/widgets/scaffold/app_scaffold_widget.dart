import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../drawers/app_drawer.dart';

class AppScaffoldWidget extends StatefulWidget {
  const AppScaffoldWidget({
    super.key,
    required this.views,
  });

  final List<Widget> views;

  @override
  State<AppScaffoldWidget> createState() => AppScaffoldWidgetState();
}

class AppScaffoldWidgetState extends State<AppScaffoldWidget> {
  int currentIndex = 0;

  // Sayfa değiştirme metodu eklendi
  void changeTab(int index) {
    if (index >= 0 && index < widget.views.length) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold key eklendi
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => showLogoutModal(context),
      child: Scaffold(
        key: scaffoldKey,
        drawer: const AppDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Categories',
                style: BaseTextStyle.titleLarge(
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    OctIcons.bell,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Transform.scale(
                    scale: 0.9,
                    alignment: Alignment.topCenter,
                    child: const Icon(
                      FontAwesome.bag_shopping_solid,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
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
        body: widget.views[currentIndex],
      ),
    );
  }
}
