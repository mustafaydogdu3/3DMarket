import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../product/values/localkeys/app_localkeys.dart';
import '../../auth/views/home/view/auth_home_view.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    BaseTextStyle.setContext(context);
    BaseTextStyle.setFont('Roboto');
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: AppLocalkeys.appName,
      home: const AuthHomeView(),
    );
  }
}
