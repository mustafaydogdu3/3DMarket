import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/profile/views/profile_view.dart';

class GenderRadioWidget extends StatelessWidget {
  const GenderRadioWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    return Row(
      children: [
        Radio(
          value: 'Male',
          groupValue: profileProvider.gender,
          onChanged: (value) async =>
              await profileProvider.updateGender(value ?? 'Male'),
        ),
        Text(
          'Male',
          style: BaseTextStyle.bodyLarge(),
        ),
        Radio(
          value: 'Female',
          groupValue: profileProvider.gender,
          onChanged: (value) async =>
              await profileProvider.updateGender(value ?? 'Female'),
        ),
        Text(
          'Female',
          style: BaseTextStyle.bodyLarge(),
        ),
      ],
    );
  }
}
