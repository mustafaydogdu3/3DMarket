import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../features/home/view/home_view.dart';
import '../../../features/profile/views/profile_view.dart';

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
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileView(),
                ),
              ),
              child: Row(
                spacing: 16,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Image.asset('assets/images/png/profil.png'),
                  ),
                  Column(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Omer Yilmaz',
                        style: BaseTextStyle.bodyLarge(),
                      ),
                      Text(
                        '+90 555 123 45 67',
                        style: BaseTextStyle.bodyMedium(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
