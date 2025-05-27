import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/scaffold/app_scaffold_widget.dart';
import '../../services/home_service.dart';
import 'categories/categories_view.dart';
import 'home/home_view.dart';

@RoutePage()
class HomeNavView extends StatefulWidget {
  const HomeNavView({super.key});

  @override
  State<HomeNavView> createState() => _HomeNavViewState();
}

class _HomeNavViewState extends State<HomeNavView> {
  final GlobalKey<AppScaffoldWidgetState> _scaffoldKey =
      GlobalKey<AppScaffoldWidgetState>();

  void navigateToTab(int index) {
    _scaffoldKey.currentState?.changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      titles: const [
        'Home',
        'Categories',
      ],
      showDrawer: true,
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
