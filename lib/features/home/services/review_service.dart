import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/review_model.dart';

class ReviewService {
  const ReviewService._();

  static ReviewService get instance => const ReviewService._();

  Future<(String?, void)> addReview(
    ReviewModel review,
    List<File> images,
  ) async {
    try {
      final userFK = FirebaseAuth.instance.currentUser?.uid;

      review = review.copyWith(
        userFK: userFK,
      );

      if (images.isNotEmpty) {
        final storageRef = FirebaseStorage.instance.ref();

        final reviewsRef = storageRef.child('reviews');

        final productReviewRef =
            reviewsRef.child(review.productFK ?? 'unknowProduct');

        final productUserReviewRef =
            productReviewRef.child(review.userFK ?? 'unknowUser');

        for (int index = 0; index < images.length; index++) {
          final image = images[index];

          productUserReviewRef.child('${index + 1}').putFile(image);
        }

        final listResult = await productUserReviewRef.listAll();

        List<String> imageUrls = [];

        for (var item in listResult.items) {
          final imageUrl = await item.getDownloadURL();

          imageUrls.add(imageUrl);
        }

        review = review.copyWith(
          imageUrls: imageUrls,
        );
      }

      await FirebaseFirestore.instance
          .collection('reviews')
          .add(review.toJson());

      return (null, ());
    } catch (e) {
      return (e.toString(), null);
    }
  }

  Future<(String?, List<ReviewModel>?)> getReviews(String? productFK) async {
    try {
      final productReviewsSnap = await FirebaseFirestore.instance
          .collection('reviews')
          .where('productFK', isEqualTo: productFK)
          .get();

      final reviews = productReviewsSnap.docs
          .map(
            (e) => ReviewModel.fromJson(e.data()),
          )
          .toList();

      reviews.sort(
        (a, b) => a.createTime!.compareTo(b.createTime!),
      );

      return (null, reviews);
    } catch (e) {
      return (e.toString(), null);
    }
  }
}
