import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

class ProfileFieldsWidget extends StatelessWidget {
  const ProfileFieldsWidget({
    super.key,
    required this.title,
    required this.name,
  });

  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: BaseTextStyle.labelSmall(),
            ),
            Text(
              name,
              style: BaseTextStyle.bodyLarge(),
            ),
          ],
        ),
      ),
    );
  }
}
