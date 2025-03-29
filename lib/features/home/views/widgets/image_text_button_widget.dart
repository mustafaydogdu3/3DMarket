import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/colors/app_colors.dart';
import '../../models/category_model.dart';

class ImageTextButtonWidget extends StatelessWidget {
  const ImageTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.category,
    required this.isSelected,
  });

  final void Function()? onPressed;
  final CategoryModel? category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: isSelected ? AppColors.primary.withValues(alpha: 0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4).add(const EdgeInsets.only(top: 8)),
      constraints: const BoxConstraints(),
      child: Column(
        children: [
          Image.network(
            category?.imageUrl ?? '',
            width: 50,
            height: 50,
          ),
          Text(
            category?.name ?? '',
            style: BaseTextStyle.titleMedium(),
          ),
        ],
      ),
    );
  }
}
