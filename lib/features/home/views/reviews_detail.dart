import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/product_model.dart';
import '../services/review_service.dart';

class ReviewsDetail extends StatefulWidget {
  const ReviewsDetail({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ReviewsDetail> createState() => _ReviewsDetailState();
}

class _ReviewsDetailState extends State<ReviewsDetail> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReviewService.instance.getReview(widget.product.id),
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.none:
            return const SizedBox();
          case ConnectionState.waiting:
            return const PopScope(
              canPop: false,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            final (error, reviews) = snap.data ?? (null, null);
            return ListView.builder(
              shrinkWrap: true,
              itemCount: reviews?.length,
              itemBuilder: (context, index) {
                final review = reviews?[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    RatingBarIndicator(
                      rating: review?.rating ?? 0,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    Text(
                      review?.heading ?? 'No Title',
                      style: BaseTextStyle.bodySmall(),
                    ),
                    Text(
                      review?.review ?? 'No Review',
                      style: BaseTextStyle.bodyMedium(),
                    ),
                  ],
                );
              },
            );
        }
      },
    );
  }
}
