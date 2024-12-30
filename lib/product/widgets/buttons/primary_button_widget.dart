import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../values/colors/app_colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.background),
          ),
        ),
        child: Text(
          text,
          style: BaseTextStyle.bodyLarge().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
