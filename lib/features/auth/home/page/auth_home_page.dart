import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../product/values/colors/app_colors.dart';
import '../../../../product/values/localkeys/app_localkeys.dart';
import '../../../../product/values/paths/app_paths.dart';

class AuthHomePage extends StatelessWidget {
  const AuthHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 48),
                  child: SvgPicture.asset(
                    AppPaths.loginIll,
                    height: MediaQuery.of(context).size.height * 0.27,
                  ),
                ),
                Wrap(
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      AppLocalkeys.loginTitle,
                      style: BaseTextStyle.titleLarge(),
                    ),
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
                              const SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalkeys.loginWithGoogle,
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
                  ],
                ),
                const Text(AppLocalkeys.or),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppColors.background),
                      ),
                    ),
                    child: const Text(
                      AppLocalkeys.loginWithEmail,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(AppLocalkeys.dontHaveAnAccount),
                TextButton(
                  onPressed: () {},
                  child: const Text(AppLocalkeys.signUp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
