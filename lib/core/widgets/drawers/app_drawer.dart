import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/services/auth_service.dart';
import '../../../features/profile/services/profile_service.dart';
import '../../router/app_route_enum.dart';
import '../../values/colors/app_colors.dart';
import '../../values/localkeys/app_localkeys.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => showLogoutModal(context),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: RawMaterialButton(
                onPressed: () =>
                    context.router.pushPath(AppRoute.myProfile.path),
                child: FutureBuilder(
                    future: ProfileService.instance.getUserProfile(),
                    builder: (context, snap) {
                      switch (snap.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final user = snap.data;

                          return Row(
                            spacing: 16,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                child: ClipOval(
                                  child: Image.network(
                                    user?.photoUrl ?? '',
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                spacing: 8,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snap.data?.name ?? '',
                                    style: BaseTextStyle.bodyLarge(),
                                  ),
                                  Text(
                                    snap.data?.phoneNumber ?? '',
                                    style: BaseTextStyle.bodyMedium(),
                                  ),
                                ],
                              ),
                            ],
                          );
                      }
                    }),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () => showLogoutModal(context),
            ),
          ],
        ),
      ),
    );
  }
}

void showLogoutModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(24),
      width: double.maxFinite,
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 24,
        children: [
          Text(
            AppLocalkeys.logoutExit,
            style: BaseTextStyle.headlineLarge(),
          ),
          Text(
            AppLocalkeys.logoutMessage,
            style: BaseTextStyle.bodyLarge(),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    AuthService.instance.logout();

                    context.router.popUntilRoot();

                    context.router.replacePath(AppRoute.authHome.path);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text(
                    'Logout',
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text(
                    'Cancel',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
