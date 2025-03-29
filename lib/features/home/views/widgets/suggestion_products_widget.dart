import 'package:auto_route/auto_route.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.gr.dart';
import '../../models/product_model.dart';
import '../../services/home_service.dart';

class SuggestionProductsWidget extends StatefulWidget {
  const SuggestionProductsWidget({super.key});

  @override
  State<SuggestionProductsWidget> createState() =>
      _SuggestionProductsWidgetState();
}

class _SuggestionProductsWidgetState extends State<SuggestionProductsWidget> {
  @override
  void initState() {
    super.initState();

    _futureSuggestionProducts = HomeService.instance.getSuggestionProducts();
  }

  late Future<(String?, List<ProductModel>?)> _futureSuggestionProducts;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureSuggestionProducts,
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
            final failureOrSuggestionProducts = snap.data;

            if (failureOrSuggestionProducts?.$1 != null) {
              final failure = failureOrSuggestionProducts?.$1;

              return Card(
                child: Text(failure ?? ''),
              );
            } else {
              final interestProducts = failureOrSuggestionProducts?.$2;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: interestProducts?.length,
                itemBuilder: (context, index) {
                  final interestProduct = interestProducts?[index];

                  return RawMaterialButton(
                    onPressed: () => context.router.push(ProductDetailsRoute(
                      product: interestProduct!,
                    )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        spacing: 8,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                  interestProduct?.imageUrls?.last ?? '')),
                          Text(
                            interestProduct?.name ?? '',
                            style: BaseTextStyle.bodyLarge(),
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Text(
                                '₺${interestProduct?.discountedPrice?.toStringAsFixed(0)}',
                                style: BaseTextStyle.labelLarge(),
                              ),
                              Text(
                                '₺${interestProduct?.price?.toStringAsFixed(0)}',
                                style: BaseTextStyle.labelLarge(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${interestProduct?.discountRate?.toStringAsFixed(0)}% OFF',
                                style: BaseTextStyle.labelLarge(
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Row(
                                spacing: 8,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    interestProduct?.rating.toString() ?? '',
                                    style: BaseTextStyle.labelLarge(),
                                  )
                                ],
                              ),
                              Text(
                                '(${interestProduct?.ratingCount})',
                                style: BaseTextStyle.labelLarge(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
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
