import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../core/router/app_router.dart';
import '../../../core/values/localkeys/app_localkeys.dart';

class AppView extends StatelessWidget {
  AppView({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    BaseTextStyle.setContext(context);
    BaseTextStyle.setFont('Roboto');

    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      title: AppLocalkeys.appName,
    );
  }
}
