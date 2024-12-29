import 'package:core/base/text/theme/extension/base_text_theme_extension.dart';
import 'package:flutter/material.dart';

class BaseTextStyle {
  BaseTextStyle._();

  static late BuildContext context;
  static late String? font;

  static void setContext(BuildContext context) =>
      BaseTextStyle.context = context;

  static setFont(String? font) => BaseTextStyle.font = font;

  static displayLarge() => context.displayLarge.copyWith(fontFamily: font);
  static displayMedium() => context.displayMedium.copyWith(fontFamily: font);
  static displaySmall() => context.displaySmall.copyWith(fontFamily: font);

  static headlineLarge() => context.headlineLarge.copyWith(fontFamily: font);
  static headlineMedium() => context.headlineMedium.copyWith(fontFamily: font);
  static headlineSmall() => context.headlineSmall.copyWith(fontFamily: font);

  static titleLarge() => context.titleLarge.copyWith(fontFamily: font);
  static titleMedium() => context.titleMedium.copyWith(fontFamily: font);
  static titleSmall() => context.titleSmall.copyWith(fontFamily: font);

  static bodyLarge() => context.bodyLarge.copyWith(fontFamily: font);
  static bodyMedium() => context.bodyMedium.copyWith(fontFamily: font);
  static bodySmall() => context.bodySmall.copyWith(fontFamily: font);

  static labelLarge() => context.labelLarge.copyWith(fontFamily: font);
  static labelMedium() => context.labelMedium.copyWith(fontFamily: font);
  static labelSmall() => context.labelSmall.copyWith(fontFamily: font);
}
