import 'package:flutter/material.dart';

import '../../../product/values/colors/app_colors.dart';
import '../../../product/values/paths/app_paths.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/views/home/view/auth_home_view.dart';
import '../../home/view/home_nav_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final authStatus = AuthService.instance.authCheck();

        if (authStatus) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeNavView(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthHomeView(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Image.asset(
          AppPaths.splashLogo,
        ),
      ),
    );
  }
}
