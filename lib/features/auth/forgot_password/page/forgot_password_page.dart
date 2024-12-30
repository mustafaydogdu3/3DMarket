import 'package:core/base/context/extension/context_extension.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../product/values/localkeys/app_localkeys.dart';
import '../../../../product/widgets/buttons/primary_button_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(bottom: context.keyboardHeight),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Wrap(
          runSpacing: 25,
          children: [
            Text(
              "Forgot Password",
              style: BaseTextStyle.headlineMedium(),
            ),
            Text(
              AppLocalkeys.enterEmailText,
              style: BaseTextStyle.bodyMedium(fontWeight: FontWeight.w400),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                prefixIcon: const Icon(Icons.email),
                labelText: 'Email',
                labelStyle: BaseTextStyle.bodyMedium(),
              ),
            ),
            PrimaryButtonWidget(
              onPressed: () {},
              text: AppLocalkeys.continueText,
            )
          ],
        ),
      ),
    );
  }
}
