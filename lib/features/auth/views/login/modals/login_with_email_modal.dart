import 'package:core/base/context/extension/context_extension.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:core/widgets/snackbar/base_snackbar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../product/validators/validator.dart';
import '../../../../../product/values/localkeys/app_localkeys.dart';
import '../../../../../product/widgets/buttons/primary_button_widget.dart';
import '../../../../home/view/home_view.dart';
import '../../../services/auth_service.dart';
import '../../forgot_password/view/forgot_password_view.dart';

class LoginWithEmailModal extends StatefulWidget {
  const LoginWithEmailModal({
    super.key,
  });

  @override
  State<LoginWithEmailModal> createState() => _LoginWithEmailModalState();
}

class _LoginWithEmailModalState extends State<LoginWithEmailModal> {
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

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
        child: Form(
          key: _formKey,
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
                validator: Validator.email,
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
                keyboardType: TextInputType.text,
                obscureText: !_passwordVisible,
                validator: (value) => Validator.password(value),
                controller: _passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
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
                        builder: (context) => const ForgotPasswordView(),
                      ),
                    ),
                    child: const Text("Forgot Password?"),
                  ),
                ],
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

                    final String? error = await _authService.login(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (!context.mounted) return;

                    Navigator.pop(context);

                    if (error == null) {
                      Navigator.popUntil(context, (route) => route.isFirst);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
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
                text: AppLocalkeys.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
