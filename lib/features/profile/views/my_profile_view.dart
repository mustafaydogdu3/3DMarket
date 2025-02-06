import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../product/values/localkeys/app_localkeys.dart';
import '../../../product/widgets/drawers/app_drawer.dart';
import '../services/profile_service.dart';
import 'edit_profile_view.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  String name = '';
  String email = '';
  String phone = '';
  String address = '';
  String gender = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProfileService().getUserProfile(),
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.none:
            return const SizedBox();

          case ConnectionState.waiting:
            return PopScope(
              canPop: false,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(AppLocalkeys.editProfil),
                ),
                drawer: const AppDrawer(),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );

          case ConnectionState.active:
          case ConnectionState.done:
            email = snap.data?.email ?? '';
            name = snap.data?.name ?? '';
            phone = snap.data?.phoneNumber ?? '';
            address = snap.data?.address ?? '';
            gender = snap.data?.gender ?? '';

            return Scaffold(
              appBar: AppBar(
                title: const Text(AppLocalkeys.editProfil),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileView(
                          address: address,
                          email: email,
                          gender: gender,
                          name: name,
                          phone: phone,
                        ),
                      ),
                    ).then(
                      (_) => setState(() {}),
                    ),
                    child: const Text('Edit Profile'),
                  )
                ],
              ),
              drawer: const AppDrawer(),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        child: Image.asset('assets/images/png/profil.png'),
                      ),
                    ),
                    ProfileFieldsWidget(title: 'Name:', name: name),
                    ProfileFieldsWidget(title: 'Email:', name: email),
                    ProfileFieldsWidget(title: 'Phone:', name: phone),
                    ProfileFieldsWidget(title: 'Address:', name: address),
                    ProfileFieldsWidget(title: 'Gender:', name: gender),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}

class ProfileFieldsWidget extends StatelessWidget {
  const ProfileFieldsWidget({
    super.key,
    required this.title,
    required this.name,
  });

  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: BaseTextStyle.labelSmall(),
            ),
            Text(
              name,
              style: BaseTextStyle.bodyLarge(),
            ),
          ],
        ),
      ),
    );
  }
}
