import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../product/values/localkeys/app_localkeys.dart';
import '../../../../../product/values/paths/app_paths.dart';
import '../../../../../product/widgets/buttons/primary_button_widget.dart';
import '../../login/modals/login_with_email_modal.dart';
import '../../register/modals/register_with_email_modal.dart';

class AuthHomeView extends StatelessWidget {
  const AuthHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 48),
                Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 24,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 48),
                      child: SvgPicture.asset(
                        AppPaths.loginIll,
                        height: MediaQuery.of(context).size.height * 0.27,
                      ),
                    ),
                    Text(
                      AppLocalkeys.loginTitle,
                      style: BaseTextStyle.headlineMedium(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Wrap(
                  runSpacing: 34,
                  alignment: WrapAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.black),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalkeys.loginWithGoogle,
                                      style: BaseTextStyle.bodyLarge(),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 0,
                                child: Brand(
                                  Brands.google,
                                  size: 30,
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Expanded(child: Divider()),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              AppLocalkeys.or,
                              style: BaseTextStyle.bodyMedium(),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: PrimaryButtonWidget(
                        onPressed: () => showModalBottomSheet(
                          isScrollControlled: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const LoginWithEmailModal(),
                        ),
                        text: AppLocalkeys.loginWithEmail,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalkeys.dontHaveAnAccount,
                  style: BaseTextStyle.bodyMedium(),
                ),
                TextButton(
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (modalContext) => const RegisterWithEmailModal(),
                  ),
                  child: Text(
                    AppLocalkeys.signUp,
                    style: BaseTextStyle.bodyMedium(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
