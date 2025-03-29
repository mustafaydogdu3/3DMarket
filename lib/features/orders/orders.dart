import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/router/app_route_enum.dart';
import '../../core/values/paths/app_paths.dart';
import '../../core/widgets/buttons/primary_button_widget.dart';
import '../../core/widgets/scaffold/app_scaffold_widget.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      title: 'Orders',
      showDrawer: true,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: SvgPicture.asset(AppPaths.orderNotFound),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'No Orders Found!',
                  style:
                      BaseTextStyle.headlineSmall(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Currently you do not have any orders. When you order something, it will appear here.',
                  textAlign: TextAlign.center,
                  style: BaseTextStyle.bodyMedium(color: Colors.grey),
                ),
                PrimaryButtonWidget(
                  text: 'Start Shopping',
                  onPressed: () {
                    context.router.replacePath(AppRoute.home.path);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
