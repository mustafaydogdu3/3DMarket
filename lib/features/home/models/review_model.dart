// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  const ReviewModel({
    required this.id,
    required this.productFK,
    this.userFK,
    required this.heading,
    required this.review,
    required this.rating,
    this.imageUrls,
    this.createTime,
  });

  final String? id;
  final String? productFK;
  final String? userFK;
  final String? heading;
  final String? review;
  final double? rating;
  final List<String>? imageUrls;
  final DateTime? createTime;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      productFK: json['productFK'],
      userFK: json['userFK'],
      heading: json['heading'],
      review: json['review'],
      rating: (json['rating'] as num).toDouble(),
      imageUrls: List<String>.from(json['imageUrls']),
      createTime: json['createTime'] != null
          ? (json['createTime'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['productFK'] = productFK;
    data['userFK'] = userFK;
    data['heading'] = heading;
    data['review'] = review;
    data['rating'] = rating;
    data['imageUrls'] = imageUrls;
    data['createTime'] = FieldValue.serverTimestamp();

    return data;
  }

  ReviewModel copyWith({
    String? id,
    String? productFK,
    String? userFK,
    String? heading,
    String? review,
    double? rating,
    List<String>? imageUrls,
    DateTime? createTime,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      productFK: productFK ?? this.productFK,
      userFK: userFK ?? this.userFK,
      heading: heading ?? this.heading,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      imageUrls: imageUrls ?? this.imageUrls,
      createTime: createTime ?? this.createTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productFK,
        userFK,
        heading,
        review,
        rating,
        imageUrls,
        createTime,
      ];
}
