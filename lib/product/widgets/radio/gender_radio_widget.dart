import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

class GenderRadioWidget extends StatefulWidget {
  const GenderRadioWidget({
    super.key,
  });

  @override
  State<GenderRadioWidget> createState() => _GenderRadioWidgetState();
}

String? gender;

class _GenderRadioWidgetState extends State<GenderRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: 'Male',
          groupValue: gender,
          onChanged: (value) => setState(() {
            gender = value;
          }),
        ),
        Text(
          'Male',
          style: BaseTextStyle.bodyLarge(),
        ),
        Radio(
          value: 'Female',
          groupValue: gender,
          onChanged: (value) => setState(() {
            gender = value;
          }),
        ),
        Text(
          'Female',
          style: BaseTextStyle.bodyLarge(),
        ),
      ],
    );
  }
}
