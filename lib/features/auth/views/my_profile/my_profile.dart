import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../product/values/localkeys/app_localkeys.dart';
import '../../../../product/widgets/buttons/primary_button_widget.dart';
import '../../../../product/widgets/radio/gender_radio_widget.dart';
import '../../../profile/services/profile_service.dart';
import '../../services/auth_service.dart';
import '../home/view/auth_home_view.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppLocalkeys.editProfil),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
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
              onTap: () async {
                await AuthService().logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthHomeView()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: ProfileService().getUserProfile(),
          builder: (context, snap) {
            emailController.text = snap.data?.email ?? '';
            nameController.text = snap.data?.name ?? '';
            phoneController.text = snap.data?.phoneNumber ?? '';
            locationController.text = snap.data?.address ?? '';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Image.asset('assets/images/png/profil.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 16,
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 18,
                            ),
                          ),
                          onPressed: () {
                            // Change profile picture action
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelStyle: BaseTextStyle.bodyMedium(),
                    labelText: AppLocalkeys.name,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelStyle: BaseTextStyle.bodyMedium(),
                    labelText: AppLocalkeys.emailId,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelStyle: BaseTextStyle.bodyMedium(),
                    labelText: AppLocalkeys.mobileNumber,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: locationController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelStyle: BaseTextStyle.bodyMedium(),
                    labelText: AppLocalkeys.location,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Gender",
                  style: BaseTextStyle.labelLarge(),
                ),
                const GenderRadioWidget(),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButtonWidget(
                    onPressed: () async {
                      final name = nameController.text.trim();
                      final email = emailController.text.trim();
                      final phoneNumber = phoneController.text.trim();
                      final address = locationController.text.trim();

                      if (name.isEmpty ||
                          email.isEmpty ||
                          phoneNumber.isEmpty ||
                          address.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all the fields.')),
                        );
                        return;
                      }
                      try {
                        final profileService = ProfileService();
                        await profileService.saveUserProfile(
                          name: name,
                          email: email,
                          phoneNumber: phoneNumber,
                          address: address,
                        );

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Profile updated successfully!')),
                        );
                      } catch (e) {
                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to save profile: $e')),
                        );
                      }
                    },
                    text: AppLocalkeys.saveChanges)
              ],
            );
          },
        ),
      ),
    );
  }
}
