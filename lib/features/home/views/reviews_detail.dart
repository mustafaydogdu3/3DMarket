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
            final failureOrReviews = snap.data;

            if (failureOrReviews?.$1 != null) {
              final failure = failureOrReviews?.$1;

              return Card(
                child: Text(failure ?? ''),
              );
            } else {
              final reviews = failureOrReviews?.$2;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: reviews?.length,
                itemBuilder: (context, index) {
                  final review = reviews?[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
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
                          maxLines: 1,
                          style: BaseTextStyle.bodyLarge(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          maxLines: 5,
                          review?.review ?? 'No Review',
                          style: BaseTextStyle.bodyMedium(),
                        ),
                        SizedBox(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                    review?.imageUrls?[index] ?? ''),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
