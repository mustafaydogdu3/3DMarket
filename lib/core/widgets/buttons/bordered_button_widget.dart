import 'package:flutter/material.dart';

import '../../values/colors/app_colors.dart';

class BorderedButtonWidget extends StatelessWidget {
  const BorderedButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(
          color: AppColors.background,
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}
