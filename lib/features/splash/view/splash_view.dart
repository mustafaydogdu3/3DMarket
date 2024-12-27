import 'package:flutter/material.dart';

import '../../../product/values/colors/app_colors.dart';
import '../../../product/values/paths/app_paths.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(child: Image.asset(AppPaths.splashLogo)),
    );
  }
}
