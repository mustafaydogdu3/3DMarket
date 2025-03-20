import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/review_model.dart';
import '../services/review_service.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key,
    required this.reviewCount,
    required this.reviews,
  });

  final int reviewCount;
  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating & Reviews',
          style: BaseTextStyle.bodyLarge(),
        ),
        FutureBuilder(future: ReviewService.instance.getAverageRating(), builder: builder)
        const Divider(),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: reviewCount,
          separatorBuilder: (context, index) => Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          itemBuilder: (context, index) {
            final review = reviews[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                RatingBarIndicator(
                  rating: review.rating ?? 0,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Color(0xFFf59e0b),
                  ),
                  itemCount: 5,
                  itemSize: 25,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.heading ?? 'No Title',
                        maxLines: 1,
                        style: BaseTextStyle.bodyLarge(
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        maxLines: 3,
                        review.review ?? 'No Review',
                        style: BaseTextStyle.bodyMedium(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: review.imageUrls?.length ?? 0,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16,
                    ),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          review.imageUrls?[index] ?? '',
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
