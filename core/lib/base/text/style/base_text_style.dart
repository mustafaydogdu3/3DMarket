import 'package:core/base/text/theme/extension/base_text_theme_extension.dart';
import 'package:flutter/material.dart';

class BaseTextStyle {
  BaseTextStyle._();

  static late BuildContext context;
  static String? _font;

  static void setContext(BuildContext context) =>
      BaseTextStyle.context = context;
  static setFont(String? font) => BaseTextStyle._font = font;

  static displayLarge({FontWeight? fontWeight, Color? color}) =>
      context.displayLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static displayMedium({FontWeight? fontWeight, Color? color}) =>
      context.displayMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static displaySmall({FontWeight? fontWeight, Color? color}) =>
      context.displaySmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static headlineLarge({FontWeight? fontWeight, Color? color}) =>
      context.headlineLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static headlineMedium({FontWeight? fontWeight, Color? color}) =>
      context.headlineMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static headlineSmall({FontWeight? fontWeight, Color? color}) =>
      context.headlineSmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static titleLarge({FontWeight? fontWeight, Color? color}) =>
      context.titleLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static titleMedium({FontWeight? fontWeight, Color? color}) =>
      context.titleMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static titleSmall({FontWeight? fontWeight, Color? color}) =>
      context.titleSmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static bodyLarge({FontWeight? fontWeight, Color? color}) =>
      context.bodyLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static bodyMedium({FontWeight? fontWeight, Color? color}) =>
      context.bodyMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static bodySmall({FontWeight? fontWeight, Color? color}) =>
      context.bodySmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static labelLarge({FontWeight? fontWeight, Color? color}) =>
      context.labelLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static labelMedium({FontWeight? fontWeight, Color? color}) =>
      context.labelMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  static labelSmall({FontWeight? fontWeight, Color? color}) =>
      context.labelSmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );
}
