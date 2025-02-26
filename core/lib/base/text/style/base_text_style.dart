import 'package:core/base/text/theme/extension/base_text_theme_extension.dart';
import 'package:flutter/material.dart';

///!  Required to use this class, you must set the context first.
class BaseTextStyle {
  BaseTextStyle._();

  static late BuildContext context;
  static String? _font;

  static void setContext(BuildContext context) =>
      BaseTextStyle.context = context;

  static setFont(String? font) => BaseTextStyle._font = font;

  ///* 96px / -1.5 letter spacing
  static displayLarge({FontWeight? fontWeight, Color? color}) =>
      context.displayLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 60px / -0.5 letter spacing
  static displayMedium({FontWeight? fontWeight, Color? color}) =>
      context.displayMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 48px / 0 letter spacing
  static displaySmall({FontWeight? fontWeight, Color? color}) =>
      context.displaySmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 32px / 0 letter spacing
  static headlineLarge({FontWeight? fontWeight, Color? color}) =>
      context.headlineLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 28px / 0 letter spacing
  static headlineMedium({FontWeight? fontWeight, Color? color}) =>
      context.headlineMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 24px / 0 letter spacing
  static headlineSmall({FontWeight? fontWeight, Color? color}) =>
      context.headlineSmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 22px / 0 letter spacing
  static titleLarge({FontWeight? fontWeight, Color? color}) =>
      context.titleLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 16px / 0.15 letter spacing
  static titleMedium({FontWeight? fontWeight, Color? color}) =>
      context.titleMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 14px / 0.1 letter spacing
  static titleSmall({FontWeight? fontWeight, Color? color}) =>
      context.titleSmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 16px / 0.5 letter spacing
  static bodyLarge({FontWeight? fontWeight, Color? color}) =>
      context.bodyLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 14px / 0.25 letter spacing
  static bodyMedium({FontWeight? fontWeight, Color? color}) =>
      context.bodyMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 12px / 0.4 letter spacing
  static bodySmall({FontWeight? fontWeight, Color? color}) =>
      context.bodySmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 14px / 0.1 letter spacing
  static labelLarge({
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
  }) =>
      context.labelLarge.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
      );

  ///* 12px / 0.5 letter spacing
  static labelMedium({FontWeight? fontWeight, Color? color}) =>
      context.labelMedium.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );

  ///* 11px / 0.5 letter spacing
  static labelSmall({FontWeight? fontWeight, Color? color}) =>
      context.labelSmall.copyWith(
        fontFamily: _font,
        fontWeight: fontWeight,
        color: color,
      );
}
