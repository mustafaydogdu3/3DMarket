import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../auth/views/my_profile/my_profile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
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
                        builder: (context) => const MyProfile(),
                      )),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Image.asset('assets/images/png/profil.png'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Omer Yilmaz',
                            style: BaseTextStyle.bodyLarge(),
                          ),
                          const SizedBox(height: 8),
                          Text('+90 555 123 45 67',
                              style: BaseTextStyle.bodyMedium()),
                        ],
                      )
                    ],
                  ),
                )),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Anasayfa'),
              onTap: () {
                Navigator.pop(context); // Drawer'ı kapatır
                // İlgili sayfaya yönlendirme yapılabilir
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ayarlar'),
              onTap: () {
                Navigator.pop(context);
                // Ayarlar sayfasına yönlendirme
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('cikis'),
              onTap: () {
                Navigator.pop(context);
                // Çıkış işlemi
              },
            ),
          ],
        ),
      ),
    );
  }
}
