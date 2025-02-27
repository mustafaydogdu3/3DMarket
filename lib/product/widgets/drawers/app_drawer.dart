import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/services/auth_service.dart';
import '../../../features/auth/views/home/view/auth_home_view.dart';
import '../../../features/profile/services/profile_service.dart';
import '../../../features/profile/views/my_profile_view.dart';
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProfileView(),
                  ),
                ),
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
                                  child: user?.photoUrl != null
                                      ? Image.network(user!.photoUrl!)
                                      : Image.asset(
                                          'assets/images/png/profil.png',
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthHomeView(),
                      ),
                    );
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
                    Navigator.pop(context);
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
