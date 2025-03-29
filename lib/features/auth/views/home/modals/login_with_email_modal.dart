import 'package:auto_route/auto_route.dart';
import 'package:core/base/context/extension/context_extension.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:core/widgets/snackbar/base_snackbar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/router/app_route_enum.dart';
import '../../../../../core/validators/validator.dart';
import '../../../../../core/values/localkeys/app_localkeys.dart';
import '../../../../../core/widgets/buttons/primary_button_widget.dart';
import '../../../services/auth_service.dart';

class LoginWithEmailModal extends StatefulWidget {
  const LoginWithEmailModal({
    super.key,
  });

  @override
  State<LoginWithEmailModal> createState() => _LoginWithEmailModalState();
}

class _LoginWithEmailModalState extends State<LoginWithEmailModal> {
  final AuthService _authService = AuthService.instance;

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
                    onPressed: () => context.router.pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                keyboardType: TextInputType.visiblePassword,
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
                    onPressed: () =>
                        context.router.pushPath(AppRoute.forgotPassword.path),
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

                    context.router.pop();

                    if (error == null) {
                      context.router.popUntilRoot();

                      context.router.replacePath(AppRoute.home.path);
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
