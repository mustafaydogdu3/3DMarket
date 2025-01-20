import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

class GenderRadioWidget extends StatefulWidget {
  const GenderRadioWidget({
    super.key,
  });

  @override
  State<GenderRadioWidget> createState() => _GenderRadioWidgetState();
}

class _GenderRadioWidgetState extends State<GenderRadioWidget> {
  String gender = "Male";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: 'Male',
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value.toString();
            });
          },
        ),
        Text(
          'Male',
          style: BaseTextStyle.bodyLarge(),
        ),
        Radio(
          value: 'Female',
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value.toString();
            });
          },
        ),
        Text(
          'Female',
          style: BaseTextStyle.bodyLarge(),
        ),
      ],
    );
  }
}
