import 'package:core/base/context/extension/context_extension.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../../product/validators/validator.dart';
import '../../../../../product/values/localkeys/app_localkeys.dart';
import '../../../../../product/widgets/buttons/primary_button_widget.dart';
import '../../../../home/view/home_view.dart';
import '../../../services/auth_service.dart';

class RegisterWithEmailModal extends StatefulWidget {
  const RegisterWithEmailModal({
    super.key,
  });

  @override
  State<RegisterWithEmailModal> createState() => _RegisterWithEmailModalState();
}

class _RegisterWithEmailModalState extends State<RegisterWithEmailModal> {
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
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
                    onPressed: () => Navigator.pop(context),
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
              TextFormField(
                validator: (value) =>
                    Validator.password(value, _repeatPasswordController.text),
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
                validator: (value) =>
                    Validator.repeatPassword(value, _passwordController.text),
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
