import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../values/colors/app_colors.dart';
import '../values/paths/app_paths.dart';

class DoneShowModal extends StatelessWidget {
  final String title;
  final String? description;
  final String confirmButtonText;

  const DoneShowModal({
    super.key,
    required this.title,
    this.description,
    required this.confirmButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.maxFinite,
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 24,
        children: [
          Image.asset(AppPaths.check),
          Text(
            title,
            textAlign: TextAlign.center,
            style: BaseTextStyle.headlineLarge(),
          ),
          if (description != null)
            Text(
              description!,
              textAlign: TextAlign.center,
              style: BaseTextStyle.bodyLarge(),
            ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(confirmButtonText),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
