// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../features/home/views/orders.dart';
import '../drawers/app_drawer.dart';

class AppScaffoldWidget extends StatefulWidget {
  const AppScaffoldWidget({
    super.key,
    this.views,
    this.actions,
    this.body,
    this.title,
    this.showDrawer = false,
    this.titles,
  }) : assert((views == null) != (body == null),
            'Either views or body must be provided, but not both.');

  final List<Widget>? views;
  final List<Widget>? actions;
  final Widget? body;
  final String? title;
  final bool showDrawer;
  final List<String>? titles;

  @override
  State<AppScaffoldWidget> createState() => AppScaffoldWidgetState();
}

class AppScaffoldWidgetState extends State<AppScaffoldWidget> {
  int currentIndex = 0;

  // Sayfa değiştirme metodu eklendi
  void changeTab(int index) {
    if (widget.views != null) {
      if (index >= 0 && index < widget.views!.length) {
        setState(() {
          currentIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold key eklendi
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return PopScope(
      canPop: !widget.showDrawer,
      onPopInvokedWithResult: (didPop, result) =>
          didPop ? null : showLogoutModal(context),
      child: Scaffold(
        key: scaffoldKey,
        drawer: widget.showDrawer ? const AppDrawer() : null,
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
              title: widget.titles != null
                  ? Text(
                      widget.titles![currentIndex],
                      style: BaseTextStyle.titleLarge(
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : widget.title != null
                      ? Text(
                          widget.title!,
                          style: BaseTextStyle.titleLarge(
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : null,
              actions: [
                ...widget.actions ?? [],
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    OctIcons.bell,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Orders(),
                      ),
                    );
                  },
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
        bottomNavigationBar: widget.views != null
            ? BottomNavigationBar(
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
              )
            : null,
        body: widget.views != null ? widget.views![currentIndex] : widget.body,
      ),
    );
  }
}
