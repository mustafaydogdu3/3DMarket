import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/router/app_route_enum.dart';
import '../../core/values/colors/app_colors.dart';
import '../../core/values/paths/app_paths.dart';
import '../auth/services/auth_service.dart';

@RoutePage()
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
          context.router.replacePath(AppRoute.home.path);
        } else {
          context.router.replacePath(AppRoute.authHome.path);
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
