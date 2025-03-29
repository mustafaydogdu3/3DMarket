import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:core/widgets/snackbar/base_snackbar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/validators/validator.dart';
import '../../../../core/values/localkeys/app_localkeys.dart';
import '../../../../core/widgets/buttons/primary_button_widget.dart';
import '../../services/auth_service.dart';

@RoutePage()
class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  final AuthService _authService = AuthService.instance;

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

                      context.router.pop();

                      if (error == null) {
                        context.router.popUntilRoot();
                        BaseSnackbarWidget.showOverlaySnackBar(
                          context: context,
                          message:
                              '${AppLocalkeys.passwordResetMessage} ${_emailController.text}',
                          backgroundColor: Colors.green,
                          style: BaseTextStyle.labelLarge(),
                        );
                      } else {
                        BaseSnackbarWidget.showOverlaySnackBar(
                          context: context,
                          message: error,
                          backgroundColor: Colors.red,
                          style: BaseTextStyle.labelLarge(),
                        );
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
