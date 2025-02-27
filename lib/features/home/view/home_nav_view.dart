import 'package:flutter/material.dart';

import '../../../product/widgets/scaffold/app_scaffold_widget.dart';
import '../services/home_service.dart';
import 'categories_view.dart';
import 'home_view.dart';

class HomeNavView extends StatefulWidget {
  const HomeNavView({super.key});

  @override
  State<HomeNavView> createState() => _HomeNavViewState();
}

class _HomeNavViewState extends State<HomeNavView> {
  // Scaffold widget'ına referans oluşturuyoruz
  final GlobalKey<AppScaffoldWidgetState> _scaffoldKey =
      GlobalKey<AppScaffoldWidgetState>();

  // Tab değiştirme metodu
  void navigateToTab(int index) {
    _scaffoldKey.currentState?.changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      key: _scaffoldKey,
      views: [
        HomeView(
          onViewAllPressed: () => navigateToTab(1),
        ),
        FutureBuilder(
          future: HomeService.instance.getMainCategories(),
          builder: (context, snap) {
            switch (snap.connectionState) {
              case ConnectionState.none:
                return const SizedBox();

              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
              case ConnectionState.done:
                return CategoriesView(categories: snap.data!.$2!);
            }
          },
        ),
      ],
    );
  }
}
