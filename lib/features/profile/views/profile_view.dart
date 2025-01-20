import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../product/values/localkeys/app_localkeys.dart';
import '../../../product/widgets/buttons/primary_button_widget.dart';
import '../../../product/widgets/drawers/app_drawer.dart';
import '../../../product/widgets/radio/gender_radio_widget.dart';
import '../services/profile_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
      drawer: const AppDrawer(),
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
              spacing: 20,
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
                Text(
                  "Gender",
                  style: BaseTextStyle.labelLarge(),
                ),
                const GenderRadioWidget(),
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
                  text: AppLocalkeys.saveChanges,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
