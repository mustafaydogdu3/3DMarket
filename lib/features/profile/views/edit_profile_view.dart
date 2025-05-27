import 'package:auto_route/annotations.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../core/values/colors/app_colors.dart';
import '../../../core/values/localkeys/app_localkeys.dart';
import '../../../core/widgets/buttons/primary_button_widget.dart';
import '../../../core/widgets/radio/gender_radio_widget.dart';
import '../../auth/models/user_model.dart';
import '../services/profile_service.dart';

@RoutePage()
class EditProfileView extends StatefulWidget {
  const EditProfileView({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  void initState() {
    super.initState();

    nameController.text = widget.user.name ?? '';
    emailController.text = widget.user.email ?? '';
    phoneController.text = widget.user.phoneNumber ?? '';
    gender = widget.user.gender;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppLocalkeys.editProfile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: widget.user.photoUrl != null
                          ? Image.network(widget.user.photoUrl!)
                          : Image.asset('assets/images/png/profil.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const CircleAvatar(
                        backgroundColor: AppColors.background,
                        radius: 16,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      onPressed: () {},
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
            Text(
              "Gender",
              style: BaseTextStyle.labelLarge(),
            ),
            GenderRadioWidget(
              gender: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            PrimaryButtonWidget(
              onPressed: () async {
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final phoneNumber = phoneController.text.trim();

                if (name.isEmpty || email.isEmpty || phoneNumber.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please fill all the fields.')),
                  );
                  return;
                }
                try {
                  await ProfileService.instance.saveUserProfile(
                    name: name,
                    email: email,
                    phoneNumber: phoneNumber,
                    gender: gender,
                  );

                  if (!context.mounted) return;

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
        ),
      ),
    );
  }
}
