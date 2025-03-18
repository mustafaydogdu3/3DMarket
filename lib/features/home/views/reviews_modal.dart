import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../product/values/localkeys/app_localkeys.dart';
import '../models/product_model.dart';
import '../services/review_service.dart';
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
                      onPressed: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const SortbyModal(),
                        );
                      },
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
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: reviews!.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              final review = reviews[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RatingBarIndicator(
                                      rating: review.rating ?? 0,
                                      itemBuilder: (context, index) =>
                                          const Icon(Icons.star,
                                              color: Colors.amber),
                                      itemCount: 5,
                                      itemSize: 25,
                                    ),
                                    Text(
                                      review.heading ?? 'No Title',
                                      maxLines: 1,
                                      style: BaseTextStyle.bodyLarge(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      review.review ?? 'No Review',
                                      maxLines: 3,
                                      style: BaseTextStyle.bodyMedium(),
                                    ),
                                    if (review.imageUrls != null &&
                                        review.imageUrls!.isNotEmpty)
                                      SizedBox(
                                        height: 80,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: review.imageUrls!.length,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(width: 16),
                                          itemBuilder: (context, index) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                review.imageUrls![index],
                                                width: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
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
