import 'package:flutter/material.dart';

import '../../../product/values/localkeys/app_localkeys.dart';
import '../../splash/view/splash_view.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: AppLocalkeys.appName,
      home: SplashView(),
    );
  }
}
