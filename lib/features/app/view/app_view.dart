import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../product/values/localkeys/app_localkeys.dart';
import '../../auth/home/page/auth_home_page.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    BaseTextStyle.setContext(context);
    BaseTextStyle.setFont('Roboto');
    return const MaterialApp(
      title: AppLocalkeys.appName,
      home: AuthHomePage(),
    );
  }
}
