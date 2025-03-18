import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../product/widgets/scaffold/app_scaffold_widget.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';
import '../services/review_service.dart';
import 'reviews_detail.dart';
import 'reviews_modal.dart';
import 'write_review_page.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    super.initState();
    future = ReviewService.instance.getOneReview(widget.product.id);
  }

  late final Future<(String?, List<ReviewModel>?)> future;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WriteReviewPage(
                  product: widget.product,
                ),
              ),
            );
          },
          icon: const Icon(BoxIcons.bx_heart),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(BoxIcons.bx_share_alt),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductCarouselImageWidget(
              product: widget.product,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name ?? '',
                    style: BaseTextStyle.titleMedium(color: Colors.grey),
                  ),
                  Text(
                    widget.product.name ?? '',
                    style: BaseTextStyle.headlineMedium(),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${widget.product.rating?.toStringAsFixed(1)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.product.ratingCount?.toInt()} Reviews',
                        style: BaseTextStyle.bodyMedium(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Text(
                        '\$${widget.product.discountedPrice?.toStringAsFixed(2)}',
                        style: BaseTextStyle.headlineMedium(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.product.discountRate != null &&
                          widget.product.discountRate! > 0)
                        Text('\$${widget.product.price?.toStringAsFixed(2)}',
                            style: BaseTextStyle.bodyLarge(color: Colors.grey)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${widget.product.discountRate?.toInt()}% OFF',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: future,
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

                      final reviewCount = reviews!.length;

                      return Card(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              ReviewWidget(
                                reviewCount: reviewCount,
                                reviews: reviews,
                              ),
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => ReviewsModal(
                                      product: widget.product,
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FutureBuilder(
                                        future: ReviewService.instance
                                            .getReview(widget.product.id),
                                        builder: (context, snap) {
                                          switch (snap.connectionState) {
                                            case ConnectionState.none:
                                              return const SizedBox();

                                            case ConnectionState.waiting:
                                              return const PopScope(
                                                canPop: false,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );

                                            case ConnectionState.active:
                                            case ConnectionState.done:
                                              final failureOrReviews =
                                                  snap.data;

                                              if (failureOrReviews?.$1 !=
                                                  null) {
                                                final failure =
                                                    failureOrReviews?.$1;

                                                return Card(
                                                  child: Text(failure ?? ''),
                                                );
                                              } else {
                                                final reviews =
                                                    failureOrReviews?.$2;
                                                return Text(
                                                  "View All ${reviews?.length} Reviews",
                                                );
                                              }
                                          }
                                        }),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCarouselImageWidget extends StatefulWidget {
  const ProductCarouselImageWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductCarouselImageWidget> createState() =>
      _ProductCarouselImageWidgetState();
}

class _ProductCarouselImageWidgetState
    extends State<ProductCarouselImageWidget> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.3,
            viewportFraction: 1.0,
            initialPage: _currentImageIndex,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
          items: widget.product.imageUrls?.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.imageUrls?.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(
                        alpha: _currentImageIndex == entry.key ? 0.9 : 0.4,
                      ),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ],
    );
  }
}
