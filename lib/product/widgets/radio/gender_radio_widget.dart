import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

class GenderRadioWidget extends StatefulWidget {
  const GenderRadioWidget({
    super.key,
    required this.gender,
    this.onChanged,
  });

  final String? gender;
  final void Function(String?)? onChanged;

  @override
  State<GenderRadioWidget> createState() => _GenderRadioWidgetState();
}

class _GenderRadioWidgetState extends State<GenderRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: 'Male',
          groupValue: widget.gender,
          onChanged: widget.onChanged,
        ),
        Text(
          'Male',
          style: BaseTextStyle.bodyLarge(),
        ),
        Radio(
          value: 'Female',
          groupValue: widget.gender,
          onChanged: widget.onChanged,
        ),
        Text(
          'Female',
          style: BaseTextStyle.bodyLarge(),
        ),
      ],
    );
  }
}
