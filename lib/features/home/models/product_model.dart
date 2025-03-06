// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.categoryFK,
    required this.name,
    required this.imageUrls,
    required this.price,
    required this.discountedPrice,
    required this.discountRate,
    required this.rating,
    required this.ratingCount,
    required this.stock,
  });

  final String? id;
  final String? categoryFK;
  final String? name;
  final List<String?>? imageUrls;
  final double? price;
  final double? discountedPrice;
  final double? discountRate;
  final double? rating;
  final double? ratingCount;
  final double? stock;

  factory ProductModel.empty() {
    return const ProductModel(
      id: '',
      name: '',
      categoryFK: '',
      imageUrls: [],
      price: 0,
      discountedPrice: 0,
      discountRate: 0,
      rating: 0,
      ratingCount: 0,
      stock: 0,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      categoryFK: json['categoryFK'],
      imageUrls: List<String>.from(json['imageUrls']),
      price: double.parse(json['price'].toString()),
      discountedPrice: double.parse(json['discountedPrice'].toString()),
      discountRate: double.parse(json['discountRate'].toString()),
      rating: double.parse(json['rating'].toString()),
      ratingCount: double.parse(json['ratingCount'].toString()),
      stock: double.parse(json['stock'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['categoryFK'] = categoryFK;
    data['imageUrls'] = imageUrls;
    data['price'] = price;
    data['discountedPrice'] = discountedPrice;
    data['discountRate'] = discountRate;
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    data['stock'] = stock;

    return data;
  }

  ProductModel copyWith({
    String? id,
    String? categoryFK,
    String? name,
    List<String?>? imageUrls,
    double? price,
    double? discountedPrice,
    double? discountRate,
    double? rating,
    double? ratingCount,
    double? stock,
  }) {
    return ProductModel(
      id: id ?? this.id,
      categoryFK: categoryFK ?? this.categoryFK,
      name: name ?? this.name,
      imageUrls: imageUrls ?? this.imageUrls,
      price: price ?? this.price,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      discountRate: discountRate ?? this.discountRate,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      stock: stock ?? this.stock,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        categoryFK,
        imageUrls,
        price,
        discountedPrice,
        discountRate,
        rating,
        ratingCount,
        stock,
      ];
}
