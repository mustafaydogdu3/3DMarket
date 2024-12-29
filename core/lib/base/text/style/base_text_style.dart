import 'package:core/base/text/theme/extension/base_text_theme_extension.dart';
import 'package:flutter/material.dart';

class BaseTextStyle {
  BaseTextStyle._();

  static late BuildContext context;
  static String? _font;
  static FontWeight? _fontWeight;

  static void setContext(BuildContext context) =>
      BaseTextStyle.context = context;

  static setFont(String? font) => BaseTextStyle._font = font;

  static setFontWeight(FontWeight weight) => _fontWeight = weight;

  static displayLarge() => context.displayLarge.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static displayMedium() => context.displayMedium.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static displaySmall() => context.displaySmall.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static headlineLarge() => context.headlineLarge.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static headlineMedium() => context.headlineMedium.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static headlineSmall() => context.headlineSmall.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static titleLarge() => context.titleLarge.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static titleMedium() => context.titleMedium.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static titleSmall() => context.titleSmall.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static bodyLarge() => context.bodyLarge.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static bodyMedium() => context.bodyMedium.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static bodySmall() => context.bodySmall.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static labelLarge() => context.labelLarge.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static labelMedium() => context.labelMedium.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );

  static labelSmall() => context.labelSmall.copyWith(
        fontFamily: _font,
        fontWeight: _fontWeight,
      );
}
