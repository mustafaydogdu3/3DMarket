import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:core/widgets/snackbar/base_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../core/router/app_route_enum.dart';
import '../../../../core/values/localkeys/app_localkeys.dart';
import '../../../../core/values/paths/app_paths.dart';
import '../../../../core/widgets/buttons/primary_button_widget.dart';
import '../../services/auth_service.dart';
import 'modals/login_with_email_modal.dart';
import 'modals/register_with_email_modal.dart';

@RoutePage()
class AuthHomeView extends StatelessWidget {
  const AuthHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 24,
                  children: [
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
                    Column(
                      spacing: 34,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: ElevatedButton(
                              onPressed: () async {
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

                                final failureOrRegisterStatus =
                                    await AuthService.instance
                                        .loginWithGoogle();

                                if (!context.mounted) return;

                                context.router.pop();

                                if (failureOrRegisterStatus.$1 == null) {
                                  final registerStatus =
                                      failureOrRegisterStatus.$2!;

                                  context.router.popUntilRoot();

                                  if (registerStatus) {
                                    context.router
                                        .replacePath(AppRoute.interest.path);
                                  } else {
                                    context.router
                                        .replacePath(AppRoute.home.path);
                                  }
                                } else {
                                  final error = failureOrRegisterStatus.$1;

                                  BaseSnackbarWidget.showOverlaySnackBar(
                                    context: context,
                                    message: error!,
                                    backgroundColor: Colors.red,
                                    style: BaseTextStyle.labelLarge(),
                                  );
                                }
                              },
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
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
                        context: context,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        useSafeArea: true,
                        builder: (modalContext) =>
                            const RegisterWithEmailModal(),
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
        ),
      ),
    );
  }
}
