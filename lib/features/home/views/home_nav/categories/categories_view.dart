import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../../models/category_model.dart';
import '../../../services/home_service.dart';
import '../../widgets/image_text_button_widget.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();

    selectedCategories = widget.categories;
    selectedCategory = selectedCategories!.first;

    // Initialize the animated list key
    _listKey = GlobalKey<AnimatedListState>();
  }

  late CategoryModel selectedCategory;
  List<CategoryModel>? selectedCategories;
  List<List<CategoryModel>> topCategories = [];

  // Key for AnimatedList
  GlobalKey<AnimatedListState>? _listKey;

  // Update categories with animation
  void _updateSelectedCategories(List<CategoryModel> newCategories) {
    // If there are existing categories, remove them with animation
    if (selectedCategories != null && selectedCategories!.isNotEmpty) {
      final oldLength = selectedCategories!.length;

      // Remove items with animation
      for (int i = oldLength - 1; i >= 0; i--) {
        final item = selectedCategories![i];
        _listKey!.currentState?.removeItem(
          i,
          (context, animation) => _buildAnimatedItem(item, animation, false),
          duration: const Duration(milliseconds: 300),
        );
      }

      // Schedule adding new items after removal animation completes
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          selectedCategories = newCategories;
          selectedCategory = newCategories.first;

          // Reset the key to create a fresh AnimatedList
          _listKey = GlobalKey<AnimatedListState>();
        });
      });
    } else {
      setState(() {
        selectedCategories = newCategories;
        selectedCategory = newCategories.first;
      });
    }
  }

  // Build animated item for insertion/removal
  Widget _buildAnimatedItem(
      CategoryModel category, Animation<double> animation, bool isSelected) {
    // Slide transition for the item
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      )),
      child: FadeTransition(
        opacity: animation,
        child: ImageTextButtonWidget(
          onPressed: () => setState(() {
            selectedCategory = category;
          }),
          category: category,
          isSelected: category == selectedCategory,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                topCategories.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _updateSelectedCategories(topCategories.last);
                          topCategories.removeLast();
                        },
                        icon: const Icon(Icons.chevron_left),
                      )
                    : const SizedBox.shrink(),
                Expanded(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: selectedCategories?.length ?? 0,
                    itemBuilder: (context, index, animation) {
                      final category = selectedCategories?[index];
                      return _buildAnimatedItem(
                        category!,
                        animation,
                        category == selectedCategory,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 7,
            child: FutureBuilder(
              future: HomeService.instance.getSubCategories(
                selectedCategory.id!,
              ),
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
                    final failureOrSubCategories = snap.data;

                    if (failureOrSubCategories?.$1 != null) {
                      final failure = failureOrSubCategories?.$1;

                      return Card(
                        child: Text(failure ?? ''),
                      );
                    } else {
                      final subCategories = failureOrSubCategories?.$2;

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (Widget child,
                            Animation<double> switcherAnimation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0), // Sağdan
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: switcherAnimation,
                              curve: Curves.easeOut,
                            )),
                            child: FadeTransition(
                              opacity: switcherAnimation,
                              child: child,
                            ),
                          );
                        },
                        child: GridView.builder(
                          key: ValueKey<String>(selectedCategory.id ?? ''),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: subCategories?.length,
                          itemBuilder: (context, index) {
                            final subCategory = subCategories?[index];

                            return TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.0, end: 1.0),
                              duration: Duration(
                                  milliseconds: 500 +
                                      (index *
                                          100)), // Her kart için farklı süre
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) {
                                // Sırayla animasyon etkisi
                                final delay = index * 0.1;
                                final adjustedValue = delay >= value
                                    ? 0.0
                                    : (value - delay) / (1.0 - delay);
                                final clampedValue =
                                    adjustedValue.clamp(0.0, 1.0);

                                return Transform.translate(
                                  offset: Offset((1.0 - clampedValue) * 100,
                                      0), // Sağdan sola kaydırma
                                  child: Opacity(
                                    opacity: clampedValue,
                                    child: child,
                                  ),
                                );
                              },
                              child: Card(
                                child: RawMaterialButton(
                                  onPressed: () {
                                    topCategories.add(selectedCategories!);
                                    _updateSelectedCategories(subCategories!);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      spacing: 4,
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            subCategory?.imageUrl ?? '',
                                          ),
                                        ),
                                        Text(
                                          subCategory?.name ?? '',
                                          style: BaseTextStyle.titleSmall(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
