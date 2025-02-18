import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../product/widgets/drawers/app_drawer.dart';
import '../models/category_model.dart';
import '../services/home_service.dart';
import 'home_view.dart';

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

    selectedCategory = widget.categories.first;
  }

  late CategoryModel selectedCategory;
  CategoryModel? selectedSubCategory;
  CategoryModel? selectedTopCategory;
  List<CategoryModel>? selectedSubCategories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Categories',
          style: BaseTextStyle.titleLarge(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              OctIcons.bell,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Transform.scale(
              scale: 0.9,
              alignment: Alignment.topCenter,
              child: const Icon(
                FontAwesome.bag_shopping_solid,
                size: 28,
              ),
            ),
          ),
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
      body: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: selectedSubCategory != null
                      ? ListView.builder(
                          itemCount: selectedSubCategories?.length,
                          itemBuilder: (context, index) {
                            final subCategory = selectedSubCategories?[index];

                            return ImageTextButtonWidget(
                              onPressed: () {},
                              category: subCategory,
                              isSelected: subCategory == selectedCategory,
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: widget.categories.length,
                          itemBuilder: (context, index) {
                            final category = widget.categories[index];

                            return ImageTextButtonWidget(
                              onPressed: () => setState(() {
                                selectedCategory = category;
                              }),
                              category: category,
                              isSelected: category == selectedCategory,
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
                selectedSubCategory != null
                    ? selectedSubCategory?.id ?? ''
                    : selectedCategory.id ?? '',
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

                      selectedSubCategories = subCategories;

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: subCategories?.length,
                        itemBuilder: (context, index) {
                          final subCategory = subCategories?[index];

                          return Card(
                            child: RawMaterialButton(
                              onPressed: () => setState(() {
                                selectedTopCategory = selectedCategory;

                                selectedSubCategory = subCategory;
                              }),
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
                          );
                        },
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
