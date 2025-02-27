import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../services/home_service.dart';
import 'widgets/carousel_slider_widget.dart';
import 'widgets/image_text_button_widget.dart';
import 'widgets/product_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    this.onViewAllPressed,
  });

  // View All butonuna basıldığında çağrılacak fonksiyon
  final VoidCallback? onViewAllPressed;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HomeService.instance.getMainCategories(),
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
            final failureOrCategories = snap.data;

            if (failureOrCategories?.$1 != null) {
              final failure = failureOrCategories?.$1;

              return Card(
                child: Text(failure ?? ''),
              );
            } else {
              final categories = failureOrCategories?.$2;

              return Container(
                padding: const EdgeInsets.all(28),
                child: ListView(
                  children: [
                    SearchBar(
                      leading: const Icon(
                        BoxIcons.bx_search,
                        color: Colors.black,
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      shadowColor: const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      hintText: 'Search Anything...',
                      hintStyle: WidgetStatePropertyAll(
                        BaseTextStyle.bodyLarge(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: BaseTextStyle.titleMedium(),
                            ),
                            TextButton(
                              // View All butonuna basıldığında onViewAllPressed callback'ini çağır
                              onPressed: widget.onViewAllPressed,
                              child: Row(
                                children: [
                                  Text(
                                    'View All',
                                    style: BaseTextStyle.labelLarge(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right_sharp),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 90,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories?.length ?? 0,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 8,
                            ),
                            itemBuilder: (context, index) {
                              final category = categories?[index];

                              return ImageTextButtonWidget(
                                onPressed: () {},
                                category: category,
                                isSelected: false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const CarouselSliderWidget(),
                    const SizedBox(
                      height: 24,
                    ),
                    const SuggestionProductsWidget(),
                  ],
                ),
              );
            }
        }
      },
    );
  }
}
