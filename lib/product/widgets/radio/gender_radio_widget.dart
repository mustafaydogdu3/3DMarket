import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

class GenderRadioWidget extends StatelessWidget {
  const GenderRadioWidget({
    super.key,
    required this.gender,
    required this.onChanged,
  });

  final String? gender;
  final void Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: 'Male',
          groupValue: gender,
          onChanged: onChanged,
        ),
        Text(
          'Male',
          style: BaseTextStyle.bodyLarge(),
        ),
        Radio(
          value: 'Female',
          groupValue: gender,
          onChanged: onChanged,
        ),
        Text(
          'Female',
          style: BaseTextStyle.bodyLarge(),
        ),
      ],
    );
  }
}
