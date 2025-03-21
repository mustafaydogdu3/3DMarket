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
      List<ProductModel> interestProducts = [];

      final currentUser = FirebaseAuth.instance.currentUser;

      final userProductSuggestionsSnap = await FirebaseFirestore.instance
          .collection('user_interests')
          .where('userFK', isEqualTo: currentUser?.uid)
          .get();

      List<String> interestFKs = [];

      for (var userProductSuggestionDoc in userProductSuggestionsSnap.docs) {
        final interestFK = userProductSuggestionDoc.data()['interestFK'];

        interestFKs.add(interestFK);
      }

      for (var interestFK in interestFKs) {
        final interestCategoriesSnap = await FirebaseFirestore.instance
            .collection('sub_categories')
            .where('interestFK', isEqualTo: interestFK)
            .get();

        for (var interestCategoryDoc in interestCategoriesSnap.docs) {
          final interestProductsSnap = await FirebaseFirestore.instance
              .collection('products')
              .where('categoryFK', isEqualTo: interestCategoryDoc.data()['id'])
              .get();

          for (var interestProductDoc in interestProductsSnap.docs) {
            final interestProduct =
                ProductModel.fromJson(interestProductDoc.data());

            interestProducts.add(interestProduct);
          }
        }
      }

      return (null, interestProducts);
    } catch (e) {
      return ('Failed to load interest products!', null);
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
