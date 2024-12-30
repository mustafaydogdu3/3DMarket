import 'package:core/base/context/extension/context_extension.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../../product/values/localkeys/app_localkeys.dart';
import '../../../../../product/widgets/buttons/primary_button_widget.dart';
import '../../../services/auth_service.dart';

class RegisterWithEmailModal extends StatefulWidget {
  const RegisterWithEmailModal({super.key});

  @override
  State<RegisterWithEmailModal> createState() => _RegisterWithEmailModalState();
}

class _RegisterWithEmailModalState extends State<RegisterWithEmailModal> {
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: context.keyboardHeight),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Wrap(
          runSpacing: 18,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalkeys.signupWithEmail,
                  style: BaseTextStyle.titleLarge(),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                labelStyle: BaseTextStyle.bodyMedium(),
                labelText: AppLocalkeys.email,
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                labelStyle: BaseTextStyle.bodyMedium(),
                labelText: AppLocalkeys.password,
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            TextFormField(
              controller: _repeatPasswordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                labelStyle: BaseTextStyle.bodyMedium(),
                labelText: AppLocalkeys.confirmPassowrd,
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            PrimaryButtonWidget(
                onPressed: () async => await _authService.register(
                      _emailController.text,
                      _passwordController.text,
                      _repeatPasswordController.text,
                    ),
                text: AppLocalkeys.signUp),
          ],
        ),
      ),
    );
  }
}
