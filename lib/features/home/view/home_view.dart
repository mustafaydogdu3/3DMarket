import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../product/values/colors/app_colors.dart';
import '../../../product/widgets/drawers/app_drawer.dart';
import '../models/category_model.dart';
import '../services/home_service.dart';
import 'categories_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Home',
          style: BaseTextStyle.titleLarge(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(OctIcons.bell)),
          IconButton(onPressed: () {}, icon: const Icon(OctIcons.bell))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesome.house_solid,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_view_outlined,
            ),
            label: 'Categories',
          ),
        ],
      ),
      body: FutureBuilder(
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: BaseTextStyle.titleMedium(),
                          ),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesView(
                                  categories: categories ?? [],
                                ),
                              ),
                            ),
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
                        height: 82,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories?.length ?? 0,
                          separatorBuilder: (context, index) => const SizedBox(
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
                );
              }
          }
        },
      ),
    );
  }
}

class ImageTextButtonWidget extends StatelessWidget {
  const ImageTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.category,
    required this.isSelected,
  });

  final void Function()? onPressed;
  final CategoryModel? category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: isSelected ? AppColors.primary.withValues(alpha: 0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(),
      child: Column(
        children: [
          Image.network(
            category?.imageUrl ?? '',
            width: 50,
            height: 50,
          ),
          Text(
            category?.name ?? '',
            style: BaseTextStyle.titleMedium(),
          ),
        ],
      ),
    );
  }
}
