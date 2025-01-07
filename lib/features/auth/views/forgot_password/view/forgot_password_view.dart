import 'package:core/base/text/style/base_text_style.dart';
import 'package:core/widgets/snackbar/base_snackbar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../product/validators/validator.dart';
import '../../../../../product/values/localkeys/app_localkeys.dart';
import '../../../../../product/widgets/buttons/primary_button_widget.dart';
import '../../../services/auth_service.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
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
                  validator: Validator.email,
                  controller: _emailController,
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const PopScope(
                          canPop: false,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );

                      final String? error = await _authService
                          .sendPasswordResetEmail(_emailController.text);

                      if (!context.mounted) return;

                      Navigator.pop(context);

                      if (error == null) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      } else {
                        BaseSnackbarWidget.showOverlaySnackBar(context, error);
                      }
                    }
                  },
                  text: AppLocalkeys.continueText,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
