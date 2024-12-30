import 'package:core/base/context/extension/context_extension.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../product/values/localkeys/app_localkeys.dart';
import '../../../../product/widgets/buttons/primary_button_widget.dart';
import '../../forgot_password/page/forgot_password_page.dart';

class LoginWithEmailModal extends StatelessWidget {
  const LoginWithEmailModal({super.key});

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
                  AppLocalkeys.loginWithEmail,
                  style: BaseTextStyle.titleLarge(),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            TextFormField(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage(),
                    ),
                  ),
                  child: const Text("Forgot Password?"),
                ),
              ],
            ),
            PrimaryButtonWidget(onPressed: () {}, text: "Login"),
          ],
        ),
      ),
    );
  }
}
