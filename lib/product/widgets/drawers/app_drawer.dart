import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/services/auth_service.dart';
import '../../../features/auth/views/home/view/auth_home_view.dart';
import '../../../features/profile/services/profile_service.dart';
import '../../../features/profile/views/my_profile_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {
              AuthService.instance.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthHomeView(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
