import 'dart:ui';

import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../product/values/localkeys/app_localkeys.dart';
import '../models/product_model.dart';
import '../services/review_service.dart';
import 'reviews_detail.dart';
import 'sortby_modal.dart';

class ReviewsModal extends StatefulWidget {
  const ReviewsModal({super.key, required this.product});

  final ProductModel product;

  @override
  State<ReviewsModal> createState() => _ReviewsModalState();
}

class _ReviewsModalState extends State<ReviewsModal> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height +
        window.viewPadding.top +
        kToolbarHeight;

    final statusBarHeight = window.viewPadding.top / 2;

    final statusBarPercentange = (statusBarHeight * 100 / deviceHeight) / 100;

    return DraggableScrollableSheet(
      initialChildSize: 1 - statusBarPercentange,
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
                Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 12),
                  child: Column(
                    children: [
                      const Divider(),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => const SortbyModal(),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: TextButton.icon(
                                    onPressed: null,
                                    style: TextButton.styleFrom(
                                      disabledForegroundColor: Colors.black87,
                                      disabledIconColor: Colors.black87,
                                    ),
                                    label: const Text('Sort By'),
                                    icon: const Icon(Icons.sort),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: const VerticalDivider(),
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: TextButton.icon(
                                    onPressed: null,
                                    style: TextButton.styleFrom(
                                      disabledForegroundColor: Colors.black87,
                                      disabledIconColor: Colors.black87,
                                    ),
                                    label: const Text('Filter'),
                                    icon: const Icon(Icons.tune),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: ReviewService.instance.getReview(widget.product.id),
                  builder: (context, snap) {
                    switch (snap.connectionState) {
                      case ConnectionState.none:
                        return const SizedBox();
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final failureOrReviews = snap.data;
                        if (failureOrReviews?.$1 != null) {
                          return Text(failureOrReviews?.$1 ?? '');
                        } else {
                          final reviews = failureOrReviews?.$2;

                          return ReviewWidget(
                            reviewCount: reviews!.length,
                            reviews: reviews,
                          );
                        }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
