import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../../core/values/localkeys/app_localkeys.dart';
import '../../../models/review_model.dart';
import '../../widgets/review_widget.dart';
import 'filter_modal.dart';
import 'sortby_modal.dart';

class ReviewsModal extends StatefulWidget {
  const ReviewsModal({super.key, required this.reviews});

  final List<ReviewModel> reviews;

  @override
  State<ReviewsModal> createState() => _ReviewsModalState();
}

class _ReviewsModalState extends State<ReviewsModal> {
  String filter = '';

  @override
  Widget build(BuildContext context) {
    List<ReviewModel> filteredReviews = filter.isNotEmpty
        ? widget.reviews.where((review) {
            final where = review.rating == double.tryParse(filter);
            return where;
          }).toList()
        : widget.reviews;

    final deviceHeight = MediaQuery.of(context).size.height +
        View.of(context).viewPadding.top +
        kToolbarHeight;

    final statusBarHeight = View.of(context).viewPadding.top / 2;

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
                      onPressed: () => context.router.pop(),
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
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => FilterModal(
                                      onSelect: (selectedFilter) {
                                        if (selectedFilter == 'All Star') {
                                          filter = '';
                                        } else if (selectedFilter != null &&
                                            selectedFilter.isNotEmpty) {
                                          filter = selectedFilter.split(' ')[0];
                                        }

                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
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
                ReviewWidget(
                  reviews: filteredReviews,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
