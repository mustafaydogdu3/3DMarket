import 'package:auto_route/auto_route.dart';
import 'package:core/base/context/extension/context_extension.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../../core/router/app_route_enum.dart';
import '../../../../../core/validators/validator.dart';
import '../../../../../core/values/localkeys/app_localkeys.dart';
import '../../../../../core/widgets/buttons/primary_button_widget.dart';
import '../../../services/auth_service.dart';

class RegisterWithEmailModal extends StatelessWidget {
  const RegisterWithEmailModal({
    super.key,
  });

  static final AuthService _authService = AuthService.instance;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final TextEditingController _emailController = TextEditingController();

  static final TextEditingController _passwordController =
      TextEditingController();

  static final TextEditingController _repeatPasswordController =
      TextEditingController();

  void _showOverlaySnackBar(
    BuildContext context,
    String message,
  ) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.keyboardHeight),
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    onPressed: () => context.router.pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              TextFormField(
                validator: Validator.email,
                keyboardType: TextInputType.emailAddress,
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
              PasswordFormFieldWidget(
                controller: _passwordController,
                labelText: AppLocalkeys.password,
                validator: (value) => Validator.password(
                  value,
                  repeatPassword: _repeatPasswordController.text,
                ),
              ),
              PasswordFormFieldWidget(
                controller: _repeatPasswordController,
                validator: (value) => Validator.repeatPassword(
                  value,
                  _passwordController.text,
                ),
                labelText: AppLocalkeys.confirmPassowrd,
              ),
              PrimaryButtonWidget(
                onPressed: () async {
                  FocusScope.of(context).unfocus();

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

                    final String? error = await _authService.register(
                      _emailController.text,
                      _passwordController.text,
                      _repeatPasswordController.text,
                    );

                    if (!context.mounted) return;

                    context.router.pop();

                    if (error == null) {
                      context.router.popUntilRoot();

                      context.router.replacePath(AppRoute.interest.path);
                    } else {
                      _showOverlaySnackBar(context, error);
                    }
                  }
                },
                text: AppLocalkeys.signUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordFormFieldWidget extends StatefulWidget {
  const PasswordFormFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String labelText;

  @override
  State<PasswordFormFieldWidget> createState() =>
      _PasswordFormFieldWidgetState();
}

class _PasswordFormFieldWidgetState extends State<PasswordFormFieldWidget> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: !_passwordVisible,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon:
              Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        labelStyle: BaseTextStyle.bodyMedium(),
        labelText: widget.labelText,
        prefixIcon: const Icon(Icons.lock),
      ),
    );
  }
}
