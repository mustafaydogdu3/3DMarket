import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../product/values/localkeys/app_localkeys.dart';
import '../models/product_model.dart';
import 'reviews_detail.dart';

class ReviewsModal extends StatefulWidget {
  const ReviewsModal({super.key, required this.product});

  final ProductModel product;

  @override
  State<ReviewsModal> createState() => _ReviewsModalState();
}

class _ReviewsModalState extends State<ReviewsModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalkeys.ratingRaviews,
                      style: BaseTextStyle.headlineSmall(color: Colors.black),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  spacing: 40,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      label: const Text('Sort By'),
                      icon: const Icon(Icons.sort),
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.grey,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      label: const Text('Filter'),
                      icon: const Icon(Icons.tune),
                    ),
                  ],
                ),
                const Divider(),
                ReviewsDetail(
                  product: widget.product,
                  showBotton: false,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
