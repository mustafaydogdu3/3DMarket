import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/slider_model.dart';

class HomeService {
  const HomeService._();

  static HomeService get instance => const HomeService._();

  Future<(String?, List<ProductModel>?)> getSuggestionProducts() async {
    try {
      List<ProductModel> suggestionProducts = [];

      final currentUser = FirebaseAuth.instance.currentUser;

      final userProductSuggestionsSnap = await FirebaseFirestore.instance
          .collection('user_product_suggestions')
          .where('userFK', isEqualTo: currentUser?.uid)
          .get();

      List<String> suggestionFKs = [];

      for (var userProductSuggestionDoc in userProductSuggestionsSnap.docs) {
        final suggestionFK = userProductSuggestionDoc.data()['suggestionFK'];

        suggestionFKs.add(suggestionFK);
      }

      for (var suggestionFK in suggestionFKs) {
        final suggestionCategoriesSnap = await FirebaseFirestore.instance
            .collection('sub_categories')
            .where('suggestionFK', isEqualTo: suggestionFK)
            .get();

        for (var suggestionCategoryDoc in suggestionCategoriesSnap.docs) {
          final suggestionProductsSnap = await FirebaseFirestore.instance
              .collection('products')
              .where('categoryFK',
                  isEqualTo: suggestionCategoryDoc.data()['id'])
              .get();

          for (var suggestionProductDoc in suggestionProductsSnap.docs) {
            final suggestionProduct =
                ProductModel.fromJson(suggestionProductDoc.data());

            suggestionProducts.add(suggestionProduct);
          }
        }
      }

      return (null, suggestionProducts);
    } catch (e) {
      return ('Failed to load suggestion products!', null);
    }
  }

  Future<(String?, List<CategoryModel>?)> getMainCategories() async {
    try {
      final categoriesSnap =
          await FirebaseFirestore.instance.collection('categories').get();

      List<CategoryModel> categories = [];

      for (var categoryDoc in categoriesSnap.docs) {
        final category = CategoryModel.fromJson(categoryDoc.data());

        categories.add(category);
      }

      return (null, categories);
    } catch (e) {
      return ('Failed to load categories!', null);
    }
  }

  Future<(String?, List<CategoryModel>?)> getSubCategories(
    String categoryFK,
  ) async {
    try {
      final subCategoriesSnap = await FirebaseFirestore.instance
          .collection('sub_categories')
          .where('categoryFK', isEqualTo: categoryFK)
          .get();

      List<CategoryModel> subCategories = [];

      for (var categoryDoc in subCategoriesSnap.docs) {
        final subCategory = CategoryModel.fromJson(categoryDoc.data());

        subCategories.add(subCategory);
      }

      return (null, subCategories);
    } catch (e) {
      return ('Failed to load sub categories!', null);
    }
  }

  Future<(String?, List<SliderModel>?)> getSliders() async {
    try {
      final slidersSnap =
          await FirebaseFirestore.instance.collection('sliders').get();

      List<SliderModel> sliders = [];

      for (var sliderDoc in slidersSnap.docs) {
        final slider = SliderModel.fromJson(sliderDoc.data());

        sliders.add(slider);
      }

      return (null, sliders);
    } catch (e) {
      return ('Failed to load categories!', null);
    }
  }
}
